#include<stdint.h>
#ifndef __MEMORYMAP__
#define __MEMORYMAP__

// some defines for the memory mapped devices and usefull Constants

#define UART_BASE 0x80000000U
// 50 MHz clock
#define CPU_FREQ 50000000U

// defines for the IO of CPU it is used in conjunction with (out/in)_data custom instructions
// opcodes are the LSB byte of the OUT_DATA custom instruction 
//  


// GPIO CODES
#define GPIO_WRITE_OPCODE 0x40
#define GPIO_READ_OPCODE  0x41
#define GPIO_READ_RISINGEDGE_CAPTURE_OPCODE 0x42
#define GPIO_READ_FALLINGEDGE_CAPTURE_OPCODE 0x43
#define GPIO_SET_EDGE_CAPTURE_CLK_SOURCE 0x44

// GPIO CODES
#define PWM_DUTYCYCLE_OPCODE 0x80
#define PWM_READ_DUTY_CYCLE_OPCODE 0x81
#define PWM_CLOCKDIVIDER_OPCODE 0x82  

// CYCLE COUNTER CODES
#define CYCLE_COUNTER_LOW 0x00
#define CYCLE_COUNTER_HIGH 0x01


#endif // __MEMORYMAP__
