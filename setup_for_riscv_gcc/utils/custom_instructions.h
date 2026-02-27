#include<stdint.h>

#ifndef __CUSTOM_INSTRUCTIONS__
#define __CUSTOM_INSTRUCTIONS__

#define UNSIGNED_BYTE 0x04 //for selecting unsigned byte in the custom IO instructions
#define SIGNED_BYTE 0x00 //for selecting signed byte in the custom IO instructions
#define UNSIGNED_HALFWORD 0x05 //for selecting unsigned halfwords in the custom IO instructions
#define SIGNED_HALFWORD 0x01 //for selecting signed halfwords in the custom IO instructions
#define WORD 0x02 //for selecting words in the custom IO instructions


// custom instruction instruction to put data
// into IO register inside custom architecture
// supports signed and unsigned bytes,half words and words
void __attribute__((noinline)) output_data(uint8_t *base,uint8_t offset,uint8_t funct3){
    // output_data <reg>,ofst 
    // output x10,0 custom instruction that is implemented on my riscv cpu
    //added offset with base and put in reg and encoded ofst as 0 
    // first ':' output operand 
    // second ':' input operand  
    // first ':' clobbered registers 
    __asm__ volatile("mv a0,%0\n\t"
        "mv a1,%1\n\t"
        "add a0,a0,a1\n\t"
        :
        :"r" (base), "r" (offset)
        :"a0", "a1"
    );
    // 000000000000 01010 FUNCT3 00000 0001000
     switch (funct3)
        {
        case UNSIGNED_BYTE:
        __asm__ volatile(".word 0x00054008\n\t"); 
        break;
        case UNSIGNED_HALFWORD:
        __asm__ volatile(".word 0x00055008\n\t"); 
        break;
        case SIGNED_BYTE:
        __asm__ volatile(".word 0x00050008\n\t"); 
        break;
        case SIGNED_HALFWORD:
        __asm__ volatile(".word 0x00051008\n\t"); 
        break;
        case WORD:
        default:
        __asm__ volatile(".word 0x00052008\n\t");
            break;
        }
}

// custom instruction that reads data from a special port and loads it into memory
// it is encoded as store instruction with a special opcode
// supports only unsigned bytes,half words and words
void __attribute__((noinline)) input_data(uint8_t *base,uint8_t offset,uint8_t funct3){
// input x10,0 custom instruction that is implemented on my riscv cpu
// this will change memory location [base+offset] to be what ever 
// is on the IN_DATA line :)
// uses a0 and a1 to calculate the address then select the instruction to 
// run depending on the desired functionality 
__asm__ volatile(
    "add a0,%1,%0\n\t"
    :
    :"r" (base), "r" (offset)
    :"a0", "a1");
    // select what instruction to run
    // 0000000 00000 01010 FUNCT3 00000 1110111
        switch (funct3)
        {
        case UNSIGNED_BYTE:
        __asm__ volatile(".word 0x00050077\n\t"); 
        volatile uint8_t val8;
        asm volatile(
            "li t0, 0x0\n\t"
            "lbu %0, 0(t0)\n\t"     // load byte
            : "=r"(val8)
            :
            : "t0"
        );
        base[offset]=val8;
        break;
        case UNSIGNED_HALFWORD:
        __asm__ volatile(".word 0x00051077\n\t");
        volatile uint16_t val16;
        asm volatile(
            "li t0, 0x0\n\t"
            "lhu %0, 0(t0)\n\t"     // load halfword
            : "=r"(val16)
            :
            : "t0"
        );
        *((uint16_t*)base)=val16;
        break;
        case WORD:
        default:
        __asm__ volatile(".word 0x00A52077\n\t");
        volatile uint32_t val;
        asm volatile(
            "li t0, 0x0\n\t"
            "lw %0, 0(t0)\n\t"     // load halfword
            : "=r"(val)
            :
            : "t0"
        );
        *((uint32_t*)base)=val;
            break;
        }
}


// function pointer that is set to ISR
// we must use inline for that on order to presere addresses :)
typedef void __attribute__((noinline)) (*ISR)(void);
// a function pointer that is going to be called once interrupt occurs
static ISR isr;

// my enable interrupts instruction uses a register 
// to store the current instruction into, meaning that return address is saved 
// inside the integer registers.
// but i used x31 explicitly, when returning from interrupts
// interrupt handler must save "x31", this is why there is an interrupt wrapper
// that will save state, then call the isr :p
void enable_interrupts(void __attribute__((noinline)) (*interrupt_handler)(void)){
// 00000 0000 0000 1010 000 0000 1011 1111 
// 00000 0000 0000 1010 000 1111 1011 1111 
// the provided isr runs after the wrapper
    isr=interrupt_handler;
    __asm__ volatile(
        "la a0,interrupt_entry\n\t"
        ".word 0x00050fbf\n\t"
        :
        :"r"(interrupt_handler)
        :"a0"
    );
}

// custom instruction that disables interrupts 
void disable_interrupts(){
    __asm__ volatile(
        // 0000 0000 0000 0000 0000 0000 0001 1111
        ".word 0x0000001f\r\n"
    );
}



// function generated because the compiler uses prologue and opilogue for x1
// thus i used this wrapper to generate and save the return addresses and return using 
// x31 custom interrupt return register
__attribute__((naked)) void interrupt_entry(void) {
__asm__ volatile (
    "addi sp, sp, -16\n\t"
    "sw a5, 4(sp)\n\t"
    "sw ra, 8(sp)\n\t"
    "sw x31, 12(sp)\n\t");
    
    // calling the provided interrupt handler inside this wrapper in order to preserve its 
    // interrupt register (x31) and rest is fine
    // a5 used to call this, so we save it too :)
    isr();
    
    __asm__ volatile (
    "lw a5, 4(sp)\n\t"
    "lw ra, 8(sp)\n\t"
    "lw x31, 12(sp)\n\t"
    "addi sp, sp, 16\n\t"
    // "la x31,main \n\t"
    "jalr x0,x31,0\n\t"      // Return to PC stored in t6
);
}

#endif // __CUSTOM_INSTRUCTIONS__
