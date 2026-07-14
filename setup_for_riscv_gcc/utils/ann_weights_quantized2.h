#ifndef ANN_WEIGHTS_Q_H
#define ANN_WEIGHTS_Q_H

#include <stdint.h>
#include"software_solutions_FPU.h"

#define LAYER_0_SIZE 1
#define LAYER_1_SIZE 4
#define LAYER_2_SIZE 8
#define LAYER_3_SIZE 8
#define LAYER_4_SIZE 4
#define LAYER_5_SIZE 1

// StandardScaler
const float INPUT_MEAN_Q = 0.00000000f;
const float INPUT_SCALE_Q = 3.62796151f;

float standardize_input(float x, float mean, float scale)
{
    return (float_sub(x,mean) / scale);
}

// Per layer symmetric uniform quantization

const float W0_SCALE = 86.05293153f;
const int8_t W0_Q[4] = {
    -80, 127, 88, -12
};

const float W1_SCALE = 113.65061409f;
const int8_t W1_Q[32] = {
    -62, 103, -120, 73, 18, -69, -91, -42, -97, 37, 12, -74, 
    107, -85, 78, -17, -30, 73, -51, -24, 113, -127, 57, -87, 
    -65, 72, 80, 54, -12, -44, 56, 30
};

const float W2_SCALE = 116.73875454f;
const int8_t W2_Q[64] = {
    -27, -81, 118, 29, 58, 110, 34, 108, -13, -18, -57, -115, 
    -79, -74, 35, -72, -54, -44, -50, 76, -41, 127, 60, -10, 
    -77, 21, 23, 51, 63, -55, -30, -54, 52, 53, -10, -79, 
    -54, -32, 43, 19, 47, -30, -71, 83, 67, 29, 38, 15, 
    39, -12, -108, -54, -86, 8, -31, -31, 55, -42, -31, 67, 
    -22, -39, -28, -44
};

const float W3_SCALE = 120.48272603f;
const int8_t W3_Q[32] = {
    63, 68, -54, -48, -34, -1, 52, 75, -115, -17, 12, -73, 
    -74, -48, 81, -42, 68, 72, -65, 127, 54, -68, 42, -73, 
    -79, -112, 39, -27, -90, -44, 96, -63
};

const float W4_SCALE = 116.70646960f;
const int8_t W4_Q[4] = {
    66, 111, -80, 127
};

const float B0_SCALE = 119.28853443f;
const int8_t B0_Q[4] = {
    -127, 21, -123, 96
};

const float B1_SCALE = 199.66430991f;
const int8_t B1_Q[8] = {
    -103, -13, -115, 127, -56, 90, -13, 72
};

const float B2_SCALE = 222.93372374f;
const int8_t B2_Q[8] = {
    127, 80, -4, 124, 105, -69, 101, -2
};

const float B3_SCALE = 265.00404052f;
const int8_t B3_Q[4] = {
    -119, -7, 127, -68
};

const float B4_SCALE = 731.43926322f;
const int8_t B4_Q[1] = {
    -127
};

#endif
