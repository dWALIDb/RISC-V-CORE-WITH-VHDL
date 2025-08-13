#include <stdint.h>
#include "memorymap.h"
#include "circular_buffer.h"

#ifndef __UART__
#   define __UART__

#define UART_DEV ((volatile uint8_t*)UART_BASE)
#define UART_CONTROLS ((volatile uint8_t*)UART_DEV + 0)
#define UART_TRANSMITTER ((volatile uint8_t*)UART_DEV + 1)
#define UART_RECIEVER ((volatile uint8_t*)UART_DEV + 2)

// define signals that control uart in order to control its behaviour
// enable transmitter/reciever must be 0 to enable UART :) 
#define TX_ENABLE 0x01 
#define RX_ENABLE 0x02 
// check if the uart is transmitting/recieving data
#define TX_READY  0x04
#define RX_READY  0x08
// send the byte, uart doesn't send data until it is high
#define TX_SEND   0x10

// enable transmitter/reciever
void uart_enable(uint8_t tx_rx);

// write data through uart via polling the ready line
void uart_write(const uint8_t* src,uint32_t size);
// read data up to specified length 
uint8_t uart_read(uint8_t* dst,uint8_t size);
// returns number of bytes recieved over uart
uint8_t uart_elem_count();
// Rx ISR, writes data on internal buffer 
void uart_Rx_ISR();
// disable transmitter/reciever
void uart_disable(uint8_t tx_rx);
#endif