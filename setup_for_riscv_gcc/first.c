//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include "utils\neural_network.h"
#include "C:\Users\DELL\Desktop\learn\python\weights.h"
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


// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    uart_Rx_ISR();
    // *UART_CONTROLS |= (0x02);
    

    
    // *UART_CONTROLS &= ~(0x02);
    enable_interrupts(interrupt_handler);
}
uint8_t b[13];



int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    
    //super loop
    // Define inputs
    float input=0.0f;
    float l0[8], l1[8], l2[8], l3[8], l4[1];  // outputs buffers for each layer

// Layer 0
uart_write("layer 0\n\r",10);
forward_pass(&input, 1, W0, B0, l0, 8);
tanh_activation(l0, 8);

// Layer 1
uart_write("layer 1\n\r",10);
forward_pass(l0, 8, W1, B1, l1, 8);
tanh_activation(l1, 8);

// Layer 2
uart_write("layer 2\n\r",10);
forward_pass(l1, 8, W2, B2, l0, 8);
tanh_activation(l0, 8);

// Layer 3
uart_write("layer 3\n\r",10);
forward_pass(l0, 8, W3, B3, l1, 8);
tanh_activation(l1, 8);

// Layer 4 (final output)
uart_write("layer 4\n\r",10);
forward_pass(l1, 8, W4, B4, l0, 1);
// Typically no activation or depends on your use case here
    uart_write("output: [ ",11);
    for (uint8_t i = 0; i < 1; i++)
    {
        memory_to_hex_ascii(&l0[i],4,b);
        uart_write(b,8);
        // print_float(layers[i]);
        uart_write(" ",1);
    }
    uart_write(" ]\n\r",5);
    
    while (1){}
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
