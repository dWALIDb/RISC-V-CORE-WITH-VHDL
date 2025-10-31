#include "utils/circular_buffer.h"

void circ_buf_init(circular_buffer* buff){
    buff->elem_count=0x00;
    buff->head=0x00;
    buff->tail=0x00;
}

void circ_buf_close(circular_buffer* buff){
    buff->elem_count=-1;
    buff->head=-1;
    buff->tail=-1;
}

int8_t circ_buf_write(circular_buffer* buff,uint8_t item){
    // if(buff==NULL || buff->head==-1){return CIRC_BUFF_ERR_NULPTR;}
    // cant use NULL cus i dont have lib std
    if(buff->head==(uint8_t)-1){return CIRC_BUFF_ERR_NULPTR;}
    //no write if full
    if(circ_buf_is_full(buff)==1){return CIRC_BUFF_ERR_FULL;}
    buff->buffer[buff->head]=item;
    buff->head= (buff->head+1)%BUFFER_SIZE;
    buff->elem_count++;
    return (int8_t)1;
}

int8_t circ_buf_read(circular_buffer* buff,uint8_t *buffer){
    if(buff->tail==(uint8_t)-1){return CIRC_BUFF_ERR_NULPTR;}
    if(circ_buf_is_empty(buff)==1){return CIRC_BUFF_ERR_EMPTY;}
    buff->elem_count-=1;
    buffer[0]=buff->buffer[buff->tail];
    buff->tail= (buff->tail+1)%BUFFER_SIZE;
    return (int8_t)1;
}
// int8_t circ_buf_read(circular_buffer* buff,uint8_t length,uint8_t *buffer){
//     // if(buff==NULL || buff->tail==-1){return CIRC_BUFF_ERR_NULPTR;}
//     // cant use NULL cus i dont have lib std
//     if(buff->tail==-1){return CIRC_BUFF_ERR_NULPTR;}
//     // no read if empty
//     if(circ_buf_is_empty(buff)==1){return CIRC_BUFF_ERR_EMPTY;}
//     uint8_t actual_read=0;
//     for(uint8_t i=0;i<length;i++){
//         if(circ_buf_is_empty(buff)==1){break;}
//         buffer[i]=buff->buffer[buff->tail];
//         buff->tail= (buff->tail+1)%BUFFER_SIZE;
//         actual_read++;
//         buff->elem_count--;
//     }
//     return actual_read;
// }

//check full buffer
uint8_t circ_buf_is_full(circular_buffer* buff){
    return (buff->elem_count>=BUFFER_SIZE)? 1 : 0;
}
// check empty buffer
uint8_t circ_buf_is_empty(circular_buffer* buff){
    return (buff->elem_count==0)? 1 : 0;
}

// check for pending data
uint8_t circ_buf_data_available(circular_buffer* buff){
    return (buff->elem_count>0) ? 1:0;
}

