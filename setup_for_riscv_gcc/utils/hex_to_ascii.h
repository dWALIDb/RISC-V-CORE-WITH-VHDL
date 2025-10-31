#include "stdint.h"
#include "uart.h"
#ifndef __HEX_TO_ASCII__
#define __HEX_TO_ASCII__

void byte_to_hex(uint8_t byte, char *out) {
    const char hex_chars[] = "0123456789ABCDEF";
    out[0] = hex_chars[(byte >> 4) & 0x0F];
    out[1] = hex_chars[byte & 0x0F];
}

void memory_to_hex_ascii(const void *addr, uint32_t length, char *output) {
    const uint8_t *data = (const uint8_t *)addr;
    for (uint32_t i = 0; i < length; i++) {
        byte_to_hex(data[length-i-1], &output[i * 2]);
    }
}


void print_int(int32_t n) {
    if ((n & 0x80000000) != 0) {    
        uart_write("-",1);
        n*=-1;
    }
    if (n == 0) {    
        uart_write("0",1);
        return;
    }
    uint8_t buf[10];  // Maximum digits in uint32_t is 10
    int8_t i = 0;

    // Extract digits in reverse
    while (n > 0) {
        buf[i++] = '0' + (n % 10);
        n /= 10;
    }

    // Reverse and send to UART
    for (int8_t j = i - 1; j >= 0; j--) {
        uart_write(&buf[j],1);
    }
}

void print_float(float x) {
    int32_t int_part = (int32_t)-x;//this is done to avoid fsub instruction because it is not supported
    float frac_part = x + int_part;
    
    int32_t int_res=(int32_t)(frac_part*10000.0f);
    
    if ((int32_t)int_res<0){
        if (int_part==0)
        {
            uart_write("-",1);
        }     
        int_res=-int_res;
    }
    
    print_int((int32_t)x);
    uart_write(".",1);
    // Handle leading zeros in fractional part (e.g., 0.0012 → "0012")
    uint8_t buf[4];
    for (int i = 3; i >= 0; i--) {
        buf[i] = '0' + (int_res % 10);
        int_res /= 10;
    }
    uart_write(buf,4);
}




// Print an integer using UART
// void print_int(int32_t n) {
//     if (n == 0) {    
//         uart_write("0", 1);
//         return;
//     }
//     if (n < 0) {    
//         uart_write("-", 1);
//         n*=-1;
//     }
//     uint8_t buf[10];  // Maximum digits in uint32_t is 10
//     int8_t i = 0;

//     // Extract digits in reverse
//     while (n > 0) {
//         buf[i++] = '0' + (n % 10);
//         n /= 10;
//     }

//     // Reverse and send to UART
//     for (int8_t j = i - 1; j >= 0; j--) {
//         uart_write(&buf[j], 1);
//     }
// }


// void print_float(float x) {
//     if ((int32_t)x < 0) {
//         uart_write("-", 1);
//         x = -x;
//     }

//     int32_t int_part = (int32_t)-x;//this is done to avoid fsub instruction because it is not supported
//     float frac_part = x + int_part;
//     int_part = -int_part;
//     int32_t int_res=(int32_t)(frac_part*10000.0f);
    
//     uint8_t b[8];
    
//     print_int(int_part);
//     uart_write(".", 1);
    
//     // Handle leading zeros in fractional part (e.g., 0.0012 → "0012")
//     uint8_t buf[4];
//     for (int i = 3; i >= 0; i--) {
//         buf[i] = '0' + (int_res % 10);
//         int_res /= 10;
//     }
//     uart_write((uint8_t *)buf, 4);
// }


#endif