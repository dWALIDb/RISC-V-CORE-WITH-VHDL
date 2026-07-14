#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils\gpio.h"
#include "utils\cycle_counter.h"
#include "utils/hex_to_ascii.h"
#include"utils\custom_instructions.h"


#define SOUND_SPEED 331  // (m/s) AT 0 °c
#define ENV_TEMPERATURE 17  //(°c)
#define CURRENT_SOUND_SPEED ((float)SOUND_SPEED+0.6f*(ENV_TEMPERATURE))

volatile uint32_t cycles_start=0;
volatile uint32_t cycles_end=0;
volatile uint32_t gp_state=0;

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

uint32_t time[10]={0};
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    // GPIO WRITE, READ EDGE CAPTURE REGISTERS and MORE!  
    // i want to detect the state of the GP_IN
    // read the capture registers
    // ensure correct timing
    // write the value i wanted :)
    gpio_set_capture_register_bit(0);
    gpio_write(0);
    while(1){
        // get 10 readings and average them out to get bettere readings, this has improved it a lot
    for (uint32_t i = 0; i < 10; i++)
    {
        /* code */
        gpio_write(1);
        delay_us(10);
        gpio_write(0);
        // read pin state 
        // test pin state
        // wait for falling edge.
    
        gp_state=gpio_read();
        while (gpio_test_bit(gp_state,0,0)){ gp_state=gpio_read();}
    
        while (gpio_test_bit(gp_state,0,1)){ gp_state=gpio_read();}
        
       cycles_start=gpio_read_edge_capture(EDGE_STATE_RISING);
       cycles_end=gpio_read_edge_capture(EDGE_STATE_FALLING);
        
        time[i]=(cycles_end-cycles_start);
        delay_ms(50);
    }
    float time_avg=0.0;
    for (uint32_t i = 0; i < 10; i++)
    {
        time_avg+=(float)time[i];
    }
    time_avg/=10.0;
    
    uart_write("cycles start:\t",15);
    print_float((float)cycles_start);
    uart_write("\n\r",2);

    uart_write("cycles end:\t",13);
    print_float((float)cycles_end);
    uart_write("\n\r",2);

    uart_write("cycles taken:\t",13);
    print_float(time_avg);
    uart_write("\n\r",2);
    
    // fast way to check
    float distance=(float)(time_avg)*0.02f /(58.0f);
    // more accurate calculation (actually more accurate :) )
    float distance2=(float)(time_avg) /(float)(CPU_FREQ);
    distance2*= (CURRENT_SOUND_SPEED/2.0f);
    distance2*=100.0f;
    uart_write("distance measured shortcut:\t",29);
    print_float(distance);
    uart_write(" cm\n\r",5);
    uart_write("distance measured more accurate:\t",34);
    print_float(distance2);
    uart_write(" cm\n\r",5);

    
    delay_ms(2000);
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
