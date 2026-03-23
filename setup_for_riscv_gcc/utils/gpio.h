#ifndef _GPIO_H_
#define GPIO_H_
// GPIO PORT CAN HOLD UPTO 24 BITS BECAUSE WORDS ARE 32 BITS AND OPCODES ARE 8 BITS :)


#include"memorymap.h"
#include"custom_instructions.h"

#define EDGE_STATE_RISING GPIO_READ_RISINGEDGE_CAPTURE_OPCODE
#define EDGE_STATE_FALLING GPIO_READ_FALLINGEDGE_CAPTURE_OPCODE

// read word from GPIO port    
uint32_t gpio_read(){
    uint32_t opcode=(uint32_t)GPIO_READ_OPCODE;
    
    output_data((uint8_t*)&opcode,0,WORD);
    input_data((uint8_t*)&opcode,0,WORD);
    return opcode;
}

// read gpio edge caputre registers, for now it is available for bit 0
// but in the future i might provide a GPIO_set_capture_register_bit or smth like that
// MUST USE THE DEFINES EDGE_STATE_RISING/FALLING
uint32_t gpio_read_edge_capture(uint8_t EDGE_STATE){
    uint32_t opcode=(uint32_t)EDGE_STATE; 
    output_data((uint8_t*)&opcode,0,WORD);
    input_data((uint8_t*)&opcode,0,WORD);
    return opcode;
}
// set what gpio bit is used to trigger the edge capture registers 
void GPIO_set_capture_register_bit(uint8_t BIT){
    uint32_t opcode=(uint32_t)GPIO_SET_EDGE_CAPTURE_CLK_SOURCE;
    opcode|=(BIT<<8); 
    output_data((uint8_t*)&opcode,0,WORD);
}
// write word into GPIO PORT
void gpio_write(uint32_t VAL){
    // this sets upper 24 bits to 0, no need to mask :)
    uint32_t opcode=(uint32_t)GPIO_WRITE_OPCODE;
    opcode|= (VAL<<8);
    output_data((uint8_t*)&opcode,0,WORD);
    opcode=0;//stop writing to port :)
    output_data((uint8_t*)&opcode,0,WORD);
}

// TEST a BIT in a VAL depending on desired state
// BITS GO FROM 0 to 31 :)
uint8_t gpio_test_bit(uint32_t VAL, uint8_t BIT, uint8_t state){
    return (((VAL >> BIT) & (uint32_t)1) == state);
}

#endif