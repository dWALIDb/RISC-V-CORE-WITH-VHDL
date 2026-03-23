#ifndef _PWM_H_
#define _PWM_H_

#include"custom_instructions.h"
#include"memorymap.h"
#include<stdint.h>

// the way it is made 
// 8 unsed|8 CLKDIV|8 DUTY CYCLE|8 opcode

// clock dividers used for PWM clock CLK_DIV0 is fastest CLK_DIV8 is slowest
#define CLK_DIV0 0x00 
#define CLK_DIV1 0x01
#define CLK_DIV2 0x02
#define CLK_DIV3 0x04
#define CLK_DIV4 0x08
#define CLK_DIV5 0x10
#define CLK_DIV6 0x20
#define CLK_DIV7 0x40
#define CLK_DIV8 0x80

void pwm_set_dutycycle(uint8_t VAL){
    uint32_t opcode=PWM_DUTYCYCLE_OPCODE;
    opcode|=(uint32_t)(VAL<<8);
    output_data((uint8_t*)&opcode,0,WORD);
    opcode=0;//stop setting dyty cycle xD
    output_data((uint8_t*)&opcode,0,WORD);
}
void pwm_set_clockdiv(uint8_t VAL){
    uint32_t opcode=PWM_CLOCKDIVIDER_OPCODE;
    opcode|=(uint32_t)(VAL<<8);
    output_data((uint8_t*)&opcode,0,WORD);
    opcode=0;//stop setting dyty cycle xD
    output_data((uint8_t*)&opcode,0,WORD);
}

uint8_t pwm_get_dutycycle(uint8_t VAL){
    uint32_t opcode=PWM_READ_DUTY_CYCLE_OPCODE;
    output_data((uint8_t*)&opcode,0,WORD);
    input_data((uint8_t*)&opcode,0,WORD);
    return opcode;
}

#endif