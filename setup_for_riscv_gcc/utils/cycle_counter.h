#ifndef _CYCLE_COUNTER_H_
#define _CYCLE_COUNTER_H_

#include "memorymap.h"
#include <stdint.h>
#include "custom_instructions.h"

#define LOWER_COUNTER_32 CYCLE_COUNTER_LOW
#define UPPER_COUNTER_32 CYCLE_COUNTER_HIGH

// read  32 bits of cycle counter
// either upper or lower depends on argument 
uint32_t read_cycle_counter(uint8_t HIGH_LOW){
    uint32_t opcode=HIGH_LOW;
    output_data((uint8_t*)&opcode,0,WORD);   
    input_data((uint8_t*)&opcode,0,WORD);
    return opcode;
}

float cycles_to_millis(uint32_t TICKS){
    float millis=0.0f;
    if (TICKS & 0x80000000) {
        millis = (float)(int32_t)(TICKS & 0x7FFFFFFF) + 2147483648.0f;
    } else {
        millis = (float)(int32_t)TICKS;
    }
    millis/=(float)CPU_FREQ;
    millis*=(float)1000.0f;
    return millis;
}



#endif