// THIS CODE GENERATES COSINE VALUES 
// ACCORDING TO STEP, THIS STEP IS DECIDED USING SAMPLING FREQUENCY 
// AND DESIRED OUTPUT FREQUENY OF GENERATED COSINE
// MASTER(PC) MUST SEND 1 BYTE OVER UART
// CPU RESPONDS WITH 4 BYTES FOR THE OUTPUT AND ANOTHER 4 BYTES FOR THE CYCLES TAKEN
// THE THEIR TYPE IS FLOAT
// SEND BYTE EACH TIME TO TRIGGER CPU :)
// THIS IS JUST A DEMO TO VISUALIZE THE GENERATED SIGNALS
// THE PYTHON SCRIPT PROFILE CODE PROVIDES VERY GOOD VISULIZATION FOR THIS CODE

#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include"utils\weights_quantized.h"
#include"utils\neural_network.h"
#include"utils\custom_instructions.h"

// PI usefull for additions and trigonometric calculations
#define TWO_PI (6.283185f)
#define PI (3.141592f)
#define FS (8000.0f)
#define F0 (440.0f)
#define STEP (float)(2*PI*F0/FS)
// negative PI usefull when subtracting :), because i have no fsub inst
float NEGATIVE_TWO_PI= (-6.283185f);
float NEGATIVE_PI =(-3.141592f);



uint32_t cycles_start=0;
uint32_t cycles_end=0;
float cycles_delay=0;
uint8_t a[8];
uint8_t res=0;
float input;
volatile uint32_t data=0,state=0;


// delay in ms
void delay_ms(uint32_t ms){
    // 4 instructions per iteration each taking 5 cycles (branch included and counter decrement)
    // then 1000 for a delay in ms ;)
    uint32_t y;
    uint32_t x;
    for (y=0 ; y<(ms) ;y++)
        for (x = 1; x < (CPU_FREQ/20)/1000; x++){
            __asm__ volatile(
                "nop \n\t"
                "nop \n\t"
            );
        }
}
void delay_us(uint32_t us){
    // 4 instructions per iteration each taking 5 cycles (branch included and counter decrement)
    uint32_t x;
    for (x = 1; x < us; x++){
        __asm__ volatile(
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
            "nop \n\t"
        );
}
}
// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    
    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}


int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    
    while(1){
    data=0x00080080;
    output_data((uint8_t*)&data,0,WORD);
    delay_ms(1000);
    
    data=0x00083380;
    output_data((uint8_t*)&data,0,WORD);
    delay_ms(1000);
    
    data=0x00086680;
    output_data((uint8_t*)&data,0,WORD);
    delay_ms(1000);
    
    data=0x00089980;
    output_data((uint8_t*)&data,0,WORD);
    delay_ms(1000);
    
    data=0x0008FF80;
    output_data((uint8_t*)&data,0,WORD);
    delay_ms(1000);
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
