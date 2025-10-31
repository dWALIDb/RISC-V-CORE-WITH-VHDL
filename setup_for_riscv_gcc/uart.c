#include<memorymap.h>
#include<uart.h>

circular_buffer uart_read_buff;

// enabling the UART transmitter/reciever or both 2 LSBs
void uart_enable(uint8_t tx_rx){
    // make sure that least 2 bits are only considered
    // send bits signal is handeled when actually sending bits :)
    *UART_CONTROLS &= ~(tx_rx & 0x03);
    circ_buf_init(&uart_read_buff);
} 

void uart_write(const uint8_t* src,uint32_t size){
    for(uint32_t i=0;i<size;i++)
    {
        while ((*UART_CONTROLS & TX_READY)==0);//block until transmision completed
        *UART_TRANSMITTER= src[i];
        *UART_CONTROLS|= TX_SEND;//enable sending bytes
        // gotta do that: else it would be stuck sending the first byte infinitly 
        *UART_CONTROLS&= ~TX_SEND;//disable sending bytes
    }
    *UART_CONTROLS&= ~TX_SEND;//disable sending bytes
    while ((*UART_CONTROLS & TX_READY)==0);//block until LAST BYTE
}

uint8_t uart_read(uint8_t* dst,uint8_t size){
    // uart_read_buff.elem_count--;//idk but it doesnt decrease elemcount inside function :( 
    circ_buf_read(&uart_read_buff,dst);
    return 1;
}

void uart_Rx_ISR(){
    uint8_t read_data=*UART_RECIEVER;//get recieved data
    circ_buf_write(&uart_read_buff,read_data);
}

// disabling the UART transmitter/reciever or both 2 LSBs
void uart_disable(uint8_t tx_rx){
    // make sure that least 2 bits are only considered
    // send bits signal is handeled when actually sending bits :)
    *UART_CONTROLS |= (tx_rx & 0x03);
    circ_buf_close(&uart_read_buff);
} 

uint8_t uart_elem_count(){
    return uart_read_buff.elem_count;
}