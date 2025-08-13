#include"stdint.h"
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
        byte_to_hex(data[i], &output[i * 2]);
    }
}

#endif