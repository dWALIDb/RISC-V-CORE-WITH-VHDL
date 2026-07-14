#ifndef _SOFTWARE_SOLUTIONS_
#define _SOFTWARE_SOLUTIONS_

// this file is to support floating point comparison, since MY FPU DOES NOT SUPPORT IT 
// thankfully gemini helped me :)

#include <stdint.h>
// got no fsub on CPU :)
float float_sub(float a, float b)
{
    float neg_b, result;
	float val=-1.0f;
    asm volatile("fmul.s %0, %1, %2" : "=f"(neg_b) : "f"(b),"f"(val));
    asm volatile("fadd.s %0, %1, %2" : "=f"(result) : "f"(a), "f"(neg_b));
    return result;
}

typedef union {
    float f;
    int32_t i;   // Signed for easier magnitude comparison
    uint32_t u;  // Unsigned for bit masking
} float_cast;

// 1. EQUAL TO (Handles -0.0 == +0.0 and NaN != NaN)
int float_eq(float a, float b) {
    float_cast ua, ub;
    ua.f = a;
    ub.f = b;

    // IEEE 754: NaN is never equal to anything, including itself
    // A NaN has all exponent bits set (0x7F800000) and a non-zero mantissa
    if (((ua.u & 0x7F800000) == 0x7F800000 && (ua.u & 0x007FFFFF) != 0) ||
        ((ub.u & 0x7F800000) == 0x7F800000 && (ub.u & 0x007FFFFF) != 0)) {
        return 0;
    }

    // Treat -0.0 and +0.0 as equal
    if ((ua.u & 0x7FFFFFFF) == 0 && (ub.u & 0x7FFFFFFF) == 0) return 1;

    return ua.u == ub.u;
}

// 2. GREATER THAN (a > b)
int float_gt(float a, float b) {
    float_cast ua, ub;
    ua.f = a;
    ub.f = b;

    // Standard check for NaN (Comparisons with NaN are always false)
    if (((ua.u & 0x7F800000) == 0x7F800000 && (ua.u & 0x007FFFFF) != 0) ||
        ((ub.u & 0x7F800000) == 0x7F800000 && (ub.u & 0x007FFFFF) != 0)) return 0;

    // Handle zeros (they are equal, so a is not greater than b)
    if ((ua.u & 0x7FFFFFFF) == 0 && (ub.u & 0x7FFFFFFF) == 0) return 0;

    int32_t ai = ua.i;
    int32_t bi = ub.i;

    // Convert signed-magnitude to biased integer for direct comparison
    // If negative, flip the bits to make larger magnitudes smaller integers
    if (ai < 0) ai = 0x80000000 - ai;
    if (bi < 0) bi = 0x80000000 - bi;

    return ai > bi;
}

// 3. LESS THAN (a < b)
int float_lt(float a, float b) {
    // Simply leverage the GT logic
    if (float_eq(a, b)) return 0;
    return !float_gt(a, b);
}

#endif