#ifndef DELAY_H_
#define DELAY_H_

#include"memorymap.h"
#include<stdint.h>
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
// not good for delays less than 10us
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

#endif