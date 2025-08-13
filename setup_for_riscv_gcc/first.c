//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils\packet.h"
#include "utils\circular_buffer.h"
#include "utils/hex_to_ascii.h"
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

uint8_t a;
uint8_t b[8];
volatile float f=1.0f;
uint32_t return_addr;
// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    uart_Rx_ISR();
    *UART_CONTROLS |= (0x02);
    
    __asm__ volatile(
        "sw x31,%0"
        :"=m"(return_addr)
    );
    uart_read(&a,1);
    uart_write("recieved : ",12);
    uart_write(&a,1);
    uart_write("\n\r",2);
    
    memory_to_hex_ascii((uint8_t*)&f,4,b);
    uart_write(b,8);
    uart_write("\n\r",2);
    
    memory_to_hex_ascii((uint8_t*)&return_addr,4,b);
    uart_write(b,8);
    uart_write("<-\n\r",5);
    
    *UART_CONTROLS &= ~(0x02);
    delay(1000);
    enable_interrupts(interrupt_handler);
}
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    //super loop
    while (1){
        f=f+3.0f;
        // delay(1000); 
    }
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
