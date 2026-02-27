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
#include"utils\custom_instructions.h"
#include"utils\cosine_table.h"



uint32_t cycles_start=0;
uint32_t cycles_end=0;
float cycles_delay=0;
uint8_t a[8];
uint8_t res=0;
float input;
volatile uint32_t data=0,state=0;


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
    uart_read(&res);
    data++;
    if (data % 2==1)
    {
        state=1;
    }else{state=0;}
       
    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}

void compute(){
    input_data((uint8_t*)cycles_start,0,WORD);
    cycles_start=*(uint32_t*)0x00000000;
    
    float output=(cosine_from_rads_interp(input)/32768.0f);
    
    input_data((uint8_t*)cycles_end,0,WORD);
    cycles_end=*(uint32_t*)0x00000000;
    cycles_delay=(float)(cycles_end-cycles_start);
    
    uart_write((uint8_t*)&output,4);
    uart_write((uint8_t*)&cycles_delay,4);
    input+=STEP;
}
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    // must not be 0, else you get weird behaviour :)
    input=0.1f;
    data=0;
    res=0;
    output_data((uint8_t*)&data,0,WORD);
    // super loop :)
    while(1){
        switch (state)
        {
        case 0:
            break;
        case 1:
        compute();
        *UART_CONTROLS |= (RX_ENABLE);
        *UART_CONTROLS &= ~(RX_ENABLE);
        enable_interrupts(interrupt_handler);
        state=0;
        data=0;
        break;

        default:
            break;
        }
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
