#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include "utils/gpio.h"
#include "utils/pwm.h"
#include "utils/cycle_counter.h"
#include "utils/delay.h"
// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    
    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}


int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    uart_write("HELLO THERE\n\r",14);
    uart_write("THIS IS THE CUSTOM API TEST\n\r",30);
    while (1)
    {
        // test GPIO write function (toggle LED)
        for (int i = 0; i < 10; i++)
        {
            gpio_write(1);
            delay_ms(100);
            gpio_write(0);
            delay_ms(100);
        }
        // set the slowest PWM clock div and also slowly increase the PWM duty cycle
        pwm_set_clockdiv(CLK_DIV8);
        for (int i = 0; i < 10; i++)
        {
            pwm_set_dutycycle(25*i);
            delay_ms(100);
        }
        pwm_set_dutycycle(0);
        // test gpio read function and if the test runs smoothly
        uint32_t state=gpio_read();
        if (gpio_test_bit(state,1,1))
             uart_write("BIT is SET\n\r",13);
        else uart_write("BIT is RESET\n\r",15);
        //capture GPIO register bit 0
        gpio_set_capture_register_bit(0);
        uint32_t clock_start=gpio_read_edge_capture(EDGE_STATE_RISING);
        uint32_t clock_end=gpio_read_edge_capture(EDGE_STATE_FALLING);
        uart_write("cycles start : ",16);
        print_int(clock_start);
        uart_write(" cycles end : ",15);
        print_int(clock_end);
        uart_write("\n\r",2);
        
        
        
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
