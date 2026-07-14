#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include "utils/cycle_counter.h"
#include "utils/delay.h"
#include "utils/cosine_table.h"
#include <stdint.h>
volatile uint8_t enable=0;
volatile uint8_t uart_byte=0;

// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    uart_Rx_ISR();
    uart_read(&uart_byte);
    enable=1;
}

float angle=0.0f;
float pcm_coef=0.0f;
float angle2=0.0f;
float coss;
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    uart_write("playing notes \n\r",17);
    enable_interrupts(interrupt_handler);
    float tones[4]={440.0f,880.0f,440.0f,880.0f};
    while (1)
    {
        switch (enable)
        {
        #define NUM_SAMPLES 8000
        #define BEATS        4
        case 1:
            uint16_t beat_interval=NUM_SAMPLES/BEATS;
            uint16_t PCM_attack=(int16_t)(0.1f*(float)beat_interval);
            uint16_t PCM_decay=(int16_t)(0.1f*(float)beat_interval);
            uint16_t PCM_sustain=beat_interval-PCM_attack-PCM_decay;

            uint32_t start = read_cycle_counter(CYCLE_COUNTER_LOW);
            for (int i = 0; i < 4; i++)
            {
                /* code */
            
            for (uint32_t n = 0; n < NUM_SAMPLES; n++)
            {                
                float t=(float)n/(float)NUM_SAMPLES;
                angle = TWO_PI*tones[i]*t;
                angle2 = angle;
                coss=cosine_from_rads_interp(&angle)/(float)INT16_MAX;

                uint32_t sample_inside_beat=n%beat_interval;
                // fade_in
                if (sample_inside_beat < PCM_attack){
                    
                    float envelope=(float)(sample_inside_beat)/(float)PCM_attack;
                    coss*=envelope;
                }
                else if (sample_inside_beat < PCM_attack+PCM_sustain)
                {

                }
                else {
                    float envelope = float_sub(1.0f , (float)(sample_inside_beat - PCM_attack - PCM_sustain) /(float) PCM_decay);
                    coss*=envelope;
                }

                uart_write((uint8_t*)&angle2,4);
                uart_write((uint8_t*)&coss,4);
                uart_write(0,4);
            }
            }
            
            uint32_t finish = read_cycle_counter(CYCLE_COUNTER_LOW);
            float response_delay=(float)(finish-start);
            uart_write((uint8_t*)&angle2,4);
            uart_write((uint8_t*)&coss,4);
            uart_write((uint8_t*)&response_delay,4);
            enable=0;
            *UART_CONTROLS |= (RX_ENABLE);
            *UART_CONTROLS &= ~(RX_ENABLE);
            enable_interrupts(interrupt_handler);
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
