#include <stdint.h> 

#ifndef __CIRC_BUFFER__
#define __CIRC_BUFFER__
// buffer size is influenced by the rate of incoming data and processing latency
// buffer size = rate of data * latency
// rate of data is 115200bps so 11520bytes per second
// and latency is 10ms giving us a buffer of 115 bytes 
// nearest power of 2 is 128
#define BUFFER_SIZE 128

// errors for checking reading and writing validity
#define CIRC_BUFF_ERR_NULPTR (int8_t)-1
#define CIRC_BUFF_ERR_FULL (int8_t)-2
#define CIRC_BUFF_ERR_EMPTY (int8_t)-3

// simple data structure that enables us to save memory using static buffers
typedef  struct circular_buffer
{
    uint8_t head;
    uint8_t buffer[BUFFER_SIZE];
    uint8_t elem_count;
    uint8_t tail;
}__attribute__((packed)) circular_buffer;

//check full buffer
uint8_t circ_buf_is_full(circular_buffer* buff);
// check empty buffer
uint8_t circ_buf_is_empty(circular_buffer* buff);
// checks for pending data
uint8_t circ_buf_data_available(circular_buffer* buff);
// sets the indicies to 0
void circ_buf_init(circular_buffer* buff);
// sets the indicies to -1
void circ_buf_close(circular_buffer* buff);
// checks for the pointer if NULL then return else push data 
// it doesn't push data if full or empty and return error codes
int8_t circ_buf_write(circular_buffer* buff,uint8_t item);
// read 1 element, 1 on success , CIRC_BUFF_ERR on failure
// doesn't read if empty or NULL pointer  and returns the error codes
int8_t circ_buf_read(circular_buffer* buff,uint8_t *buffer);

#endif