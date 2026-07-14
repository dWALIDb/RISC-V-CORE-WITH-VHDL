#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils\gpio.h"
#include "utils\cycle_counter.h"
#include "utils/hex_to_ascii.h"
#include"utils\custom_instructions.h"



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
    
    /* code */
        gpio_write(0x10);
        delay_us(10);
        gpio_write(0x00);
        delay_us(10);
        gpio_write(0x20);
        delay_us(10);
        gpio_write(0);
        
        
    delay_us(200);

    uint8_t bytes[8]={0};
    int state=gpio_read();
    state>>=2;
    state&=0xFF;
    uart_write("raw reading: ",14);
    memory_to_hex_ascii(&state,4,bytes);
    uart_write(bytes,8);
    uart_write("\tcorresponds to: ",18);
    float volts=state * 5.0395f/255.0f;
    print_float(volts);
    uart_write(" v\n\r",4);
    
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
