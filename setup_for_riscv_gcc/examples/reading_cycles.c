//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include"utils\custom_instructions.h"

// delay in ms
void delay(uint32_t ms){
    // 4 instructions per iteration each taking 4 cycles
    // then 1000 for a delay in ms ;)
    for (uint32_t y=0 ; y<ms ;y++)
        for (uint32_t i = 0; i < (CPU_FREQ/20)/1000; i++){
            __asm__ volatile(
                "nop \n\t"
                "nop \n\t"
                "nop \n\t"
                "nop \n\t"
            );
        }
}
    
// just incase the needed BGEU does not work
// it is working now, but i had some trouble with it before
uint32_t is_greater_equal(uint32_t rs1,uint32_t rs2){
    uint32_t res;
    __asm__ volatile (
        "sltu %0,%1,%2 \t\n"
        :"=r"(res)//outputs numbered first, then inputs 0-> end :)
        :"r"(rs1),"r"(rs2)
    );
    return (res ^ 0x00000001);
}


volatile uint32_t data;
volatile uint32_t cycles;
// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    // uart_Rx_ISR();
    data=0;
    output_data((uint8_t*)&data,0,WORD);   
    input_data((uint8_t*)&cycles,0,WORD);
    cycles=*(uint32_t *)0x00000000;
    uart_write("CYCLES LOW PART:\t",17);
    print_int(cycles);
    uart_write("\n\r",2);

    data=1;
    output_data((uint8_t*)&data,0,WORD);   
    input_data((uint8_t*)&cycles,0,WORD);
    cycles=*(uint32_t *)0x00000000;
    uart_write("CYCLES HIGH PART:\t",18);
    print_int(cycles);
    uart_write("\n\r",2);


    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}
// this example provides examples on reading the accuarate cycles that passed
// unfortunatly my custom in_data instruction does not accurately execute
// instead of reading into the memory location i provide it reads into the 
// memory location 0 always :( PAAAAAAIIIIIIIINNNN
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    while (1){/* code */}
    
return 0;
}



// function doesnt affect sp nor save return address,used to init data and to 
// run at startup, before anything else, it gets stack start from the linker script
extern int _stack_start;
__attribute__((naked, noreturn))
void __attribute__((section(".text.Reset"))) Reset(){
    
    __asm__ volatile ("la sp,_stack_start\n\t");//set sp to last memory location
    disable_interrupts();    
    uart_disable(TX_ENABLE|RX_ENABLE);
    main();
}
