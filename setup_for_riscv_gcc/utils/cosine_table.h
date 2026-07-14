#ifndef COSINE_TABLE
#define COSINE_TABLE

#include<stdint.h>
#include"software_solutions_FPU.h"

#define TABLE_SIZE 256

const int16_t cosine_table[256] = {
 32767, 32757, 32728, 32678, 32609, 32521, 32412, 32285, 32137, 31971, 31785, 31580,
 31356, 31113, 30852, 30571, 30273, 29956, 29621, 29268, 28898, 28510, 28105, 27683,
 27245, 26790, 26319, 25832, 25329, 24811, 24279, 23731, 23170, 22594, 22005, 21403,
 20787, 20159, 19519, 18868, 18204, 17530, 16846, 16151, 15446, 14732, 14010, 13279,
 12539, 11793, 11039, 10278,  9512,  8739,  7962,  7179,  6393,  5602,  4808,  4011,
  3212,  2410,  1608,   804,     0,  -804, -1608, -2410, -3212, -4011, -4808, -5602,
 -6393, -7179, -7962, -8739, -9512,-10278,-11039,-11793,-12539,-13279,-14010,-14732,
-15446,-16151,-16846,-17530,-18204,-18868,-19519,-20159,-20787,-21403,-22005,-22594,
-23170,-23731,-24279,-24811,-25329,-25832,-26319,-26790,-27245,-27683,-28105,-28510,
-28898,-29268,-29621,-29956,-30273,-30571,-30852,-31113,-31356,-31580,-31785,-31971,
-32137,-32285,-32412,-32521,-32609,-32678,-32728,-32757,-32767,-32757,-32728,-32678,
-32609,-32521,-32412,-32285,-32137,-31971,-31785,-31580,-31356,-31113,-30852,-30571,
-30273,-29956,-29621,-29268,-28898,-28510,-28105,-27683,-27245,-26790,-26319,-25832,
-25329,-24811,-24279,-23731,-23170,-22594,-22005,-21403,-20787,-20159,-19519,-18868,
-18204,-17530,-16846,-16151,-15446,-14732,-14010,-13279,-12539,-11793,-11039,-10278,
 -9512, -8739, -7962, -7179, -6393, -5602, -4808, -4011, -3212, -2410, -1608,  -804,
     0,   804,  1608,  2410,  3212,  4011,  4808,  5602,  6393,  7179,  7962,  8739,
  9512, 10278, 11039, 11793, 12539, 13279, 14010, 14732, 15446, 16151, 16846, 17530,
 18204, 18868, 19519, 20159, 20787, 21403, 22005, 22594, 23170, 23731, 24279, 24811,
 25329, 25832, 26319, 26790, 27245, 27683, 28105, 28510, 28898, 29268, 29621, 29956,
 30273, 30571, 30852, 31113, 31356, 31580, 31785, 31971, 32137, 32285, 32412, 32521,
 32609, 32678, 32728, 32757
};

#define TWO_PI (6.283185f)
#define PI (3.141592f)
#define FS (8000.0f)
#define F0 (440.0f)
#define STEP (float)(TWO_PI*F0/FS)
float MINUS_TWO_PI= (-6.283185f);

float my_sub(float a, float b)
{
    float neg_b, result;
	float val=-1.0f;
    asm volatile("fmul.s %0, %1, %2" : "=f"(neg_b) : "f"(b),"f"(val));
    asm volatile("fadd.s %0, %1, %2" : "=f"(result) : "f"(a), "f"(neg_b));
    return result;
}

int16_t cosine_from_rads_interp(float* angle_rad){
    // 2. USE THE SOFTWARE WRAP (Bit-accurate comparison)
    // This prevents the 38 and 69.11 crashes
    while (float_gt(*angle_rad, TWO_PI)) {
        *angle_rad = my_sub(*angle_rad , TWO_PI);
    }
    while (float_lt(*angle_rad, 0.0f)) {
        *angle_rad = *angle_rad + TWO_PI;
    }

    // 3. SCALE TO TABLE (0.0 to 255.999)
    // 256 / 6.283185 = 40.74366
    float phase_f = *angle_rad * 40.74366f;

    // 4. INTEGER CASTING (Keep it local and simple)
    uint32_t i_part = (uint32_t)phase_f;
    uint8_t i0 = (uint8_t)(i_part & 0xFF); 
    uint8_t i1 = (uint8_t)((i0 + 1) & 0xFF); 

    float frac = my_sub(phase_f , (float)i_part);

    // 5. SIGNED INTERPOLATION
    // We cast to int32_t during the math to prevent 16-bit overflow
    int32_t y0 = (int32_t)cosine_table[i0];
    int32_t y1 = (int32_t)cosine_table[i1];

    int32_t result = y0 + (int32_t)(frac * (float)(y1 - y0));

    return (int16_t)result;
}
// // uses radians, convert rads to 8 bit index
// int16_t cosine_from_rads_interp(float* angle_rad)
// {
//     // Wrap angle first (important!)
//     while (float_gt(*angle_rad, TWO_PI))   *angle_rad = my_sub(*angle_rad , TWO_PI);
//     while (float_lt(*angle_rad, 0.0f))     *angle_rad = *angle_rad + TWO_PI;
    

//     // Convert radians directly to 0–256 phase
//     float phase_f = *angle_rad * (TABLE_SIZE / TWO_PI);

//     // Integer part (auto-wrap via uint8_t)
//     uint16_t phase_i = (uint16_t)phase_f;
//     uint8_t i0 = (uint8_t)phase_i;
//     uint8_t i1 = i0 + 1;  // auto wraps 255→0

//     // Fractional part

//     float frac = my_sub(phase_f,(float)phase_i);
//     // float frac = phase_f + (float)(-phase_i);

//     // Lookup
//     uint16_t y0 = cosine_table[i0];
//     uint16_t y1 = cosine_table[i1];

//     // Linear interpolation
//     return (int16_t)(y0 + frac * (float)(y1 - y0));
// }

// int16_t cosine_from_rads_interp(float angle_rad)
// {
//     // Wrap angle
//     while ((int32_t)angle_rad < 0) angle_rad += TWO_PI;
//     while ((int32_t)(angle_rad*10) >= 6.2) angle_rad += MINUS_TWO_PI;

//     // Compute float index
//     float f_index = angle_rad / TWO_PI * TABLE_SIZE;
//     uint8_t i0 = (uint8_t)f_index;
//     uint8_t i1 = (i0 + 1) % TABLE_SIZE;
//     float frac = f_index + (float)(-i0);

//     // Linear interpolation
//     int16_t y0 = cosine_table[i0];
//     int16_t y1 = cosine_table[i1];
//     return (int16_t)(y0 + frac * (y1 - y0));
// }



// 🎯 The Real Difference
// First Version: Angle Domain Control

// You tried to force:
// angle ∈ [0, 2π)
// This requires:
// Float comparisons
// Careful boundary logic // Precise math // Easy to break.


// Second Version: Phase Domain Control

// We mapped:
// 0 → 0
// 2π → 256

// And used natural integer overflow.

// That is:
// Deterministic // Branch-free // Hardware-friendly // Immune to small floating errors // Much more “embedded correct”.

// 🧠 Deep Insight
// When your lookup table size is a power of two:
// It is almost always better to wrap the INDEX than wrap the ANGLE.
// Because hardware naturally supports modulo 2ⁿ via overflow.
// That’s why DDS (Direct Digital Synthesis) always uses phase accumulators instead of angle wrapping.

#endif