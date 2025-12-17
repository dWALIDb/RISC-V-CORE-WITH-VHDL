#include"utils/packet.h"
#include"utils/uart.h"

typedef enum reception_state {
    MSG_LENGTH , DATA_BYTES , CRC_LOW , CRC_HIGH , CRC_CHECK , SPECIAL_MSG
} reception_state;

static packet transmition_copy={0};
static packet construction_packet={0};
static packet available_packet={0};
static reception_state state = MSG_LENGTH;
static uint8_t write_index=0;
static uint8_t available;

uint8_t packet_available(){
    return available;
}

void update_packet(){
    while(uart_elem_count()>0)
    {
        switch(state){
            // get data length, if data length is 0 then we need to check retransmit
            case MSG_LENGTH:
            write_index=0;
            uart_read(&construction_packet.length);
            if (construction_packet.length==0)
                state=SPECIAL_MSG;
            else state=DATA_BYTES;
            break;
            
            case DATA_BYTES:
            uart_read(&construction_packet.msg[write_index++]);
            if (write_index>=construction_packet.length){
                write_index=0;
                state=CRC_LOW;
            }
            break;

            case SPECIAL_MSG:
            uart_read(&construction_packet.msg[write_index++]);
            if (construction_packet.msg[0]==PACKET_CORRECT)
                state=MSG_LENGTH;
            else send_packet(&transmition_copy);//retransmit
            break;

            case CRC_LOW:  
            uart_read(&construction_packet.crc_low);
            state=CRC_HIGH;
            break;
            
            case CRC_HIGH:
            uart_read(&construction_packet.crc_high);
            uint16_t crc=compute_crc((uint8_t*)&construction_packet,construction_packet.length+1);
            if (crc==(construction_packet.crc_high | (construction_packet.crc_high<<8)))
            {
                // success send 2 bytes, one for 0 length then send successfull send
                uint16_t msg=0x0000 | (PACKET_CORRECT<<8);
                uart_write((uint8_t*)msg,2);
                
                available_packet.length= construction_packet.length;
                for(uint8_t i=0;i<construction_packet.length;i++){
                available_packet.msg[i]= construction_packet.msg[i];
                }
                available_packet.crc_low= construction_packet.crc_low;
                available_packet.crc_high= construction_packet.crc_high;
                available=1;
            }
            else {
                // request retransmit
                uint16_t msg=0x0000 | (PACKET_WRONG<<8);
                uart_write((uint8_t*)msg,2);
                available=0;
            }
            state=MSG_LENGTH;
            break;
            
        }
    }
}

void static copy_packet(const packet* pkt){
    transmition_copy.length= pkt->length;
    for(uint8_t i=0;i<pkt->length;i++){
        transmition_copy.msg[i]= pkt->msg[i];
    }
    transmition_copy.crc_low= pkt->crc_low;
    transmition_copy.crc_high= pkt->crc_high;
}

void send_packet(const packet* pkt){
    uart_write(&pkt->length,1);
    uart_write(pkt->msg,pkt->length);
    uart_write(&pkt->crc_low,2);//send crc low then high
    copy_packet(pkt);
}

void send_packet_bytes(const uint8_t* msg,uint8_t length){
    transmition_copy.length= length;
    for(uint8_t i=0;i<length;i++){
        transmition_copy.msg[i]= msg[i];
    }
    uint16_t crc=compute_crc((uint8_t*)&transmition_copy,length+1);
    transmition_copy.crc_low=(uint8_t)(crc & 0x00FF);
    transmition_copy.crc_high=(uint8_t)(crc>>8);
    send_packet(&transmition_copy);
}


void read_packet(packet* pkt){
    pkt->length=available_packet.length;
    for(uint8_t i=0;i<pkt->length;i++){
        pkt->msg[i]=available_packet.msg[i];
    }
    pkt->crc_low=available_packet.crc_low;
    pkt->crc_high=available_packet.crc_high;
}


uint16_t compute_crc(const uint8_t* msg, uint8_t length){
     uint16_t crc = 0xFFFF;
    for (uint16_t i = 0; i < length; i++) {
        crc ^= msg[i];

        for (uint8_t j = 0; j < 8; j++) {
            if (crc & 0x0001)
                crc = (crc >> 1) ^ 0xA001;  // Modbus polynomial
            else
                crc >>= 1;
        }
    }
    return crc;  // LSB-first: low byte first, high byte second
}