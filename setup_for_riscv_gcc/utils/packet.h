#include <stdint.h>

#ifndef __PACKET__
#define __PACKET__

#define MSG_SIZE 128
#define CRC_FUNC 0xA001 //modbus 16 bit crc :)

#define PACKET_CORRECT 69
#define PACKET_WRONG 12

//custom packet protocol ;) modbus crc check and 16 bits
// used reversed computation cuz network people like msb first :(
// send data, wait for 2 bytes first is 0 and other is status :)
typedef struct packet{
    uint8_t length;
    uint8_t msg[MSG_SIZE];
    uint8_t crc_low;
    uint8_t crc_high;
} __attribute__((packed)) packet;
// construct packet from the bytes recieved over uart
// once successfully done it can be coppied using read_packet
// this should run inside isr after reading bytes
void update_packet();
// send packet over uart
void send_packet(const packet* pkt);
// read packet that has been forming
void read_packet(packet* pkt);
// send packet over uart
void send_packet_bytes(const uint8_t* msg,uint8_t length);
// 16 bit modbus crc
uint16_t compute_crc(const uint8_t* msg,uint8_t length);
// check availability of new packet
uint8_t packet_available();

#endif