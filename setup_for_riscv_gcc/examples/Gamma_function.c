//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include"utils\custom_instructions.h"
#include"utils\uart.h"
#include"utils/hex_to_ascii.h"
#include"utils\software_solutions_FPU.h"
#include"utils\cycle_counter.h"
uint32_t x=0;
float l0[16], l1[16];  // outputs buffers for each layer
uint8_t a[4];
volatile float input;
volatile uint32_t data=1,state=0;


// // 1. Square Root (Optimized Newton-Raphson)
// float custom_sqrt(float x) {
//     if (float_lt(x, 0.0f)) return -1.0f; 
//     if (float_eq(x, 0.0f) || float_eq(x, 1.0f)) return x;

//     float guess = x / 2.0f;
//     float last_guess;
//     float diff;
    
//     // Tightened iteration loop condition using exact bit thresholds
//     for (int i = 0; i < 10; i++) {
//         last_guess = guess;
//         guess = 0.5f * (guess + x / guess);
        
//         diff = guess - last_guess;
//         if (float_lt(diff, 0.0f)) diff = -diff; 
//         if (float_lt(diff, 1e-7f)) break; 
//     }
//     return guess;
// }

// // 2. Exponential Function (High Accuracy Taylor + Bit Scaling)
// float custom_exp(float x) {
//     if (float_eq(x, 0.0f)) return 1.0f;

//     int int_part = (int)x;
//     float frac_part = x - (float)int_part;

//     // Increased expansion depth to 12 for clean 24-bit mantissa precision
//     float term = 1.0f;
//     float exp_frac = 1.0f;
//     for (int i = 1; i <= 12; i++) { 
//         term *= frac_part / (float)i;
//         exp_frac += term;
//     }

//     float e = 2.71828182f;
//     float exp_int = 1.0f;
//     int p = float_lt((float)int_part, 0.0f) ? -int_part : int_part;
//     float base = float_lt((float)int_part, 0.0f) ? (1.0f / e) : e;

//     while (p > 0) {
//         if (p % 2 == 1) exp_int *= base;
//         base *= base;
//         p /= 2;
//     }

//     return exp_int * exp_frac;
// }

// // 3. Sine Function (Fixed Range Reduction via Integer Casts)
// float custom_sin(float x) {
//     const float PI = 3.14159265f;
//     const float TWO_PI = 6.28318530f;
    
//     // Faster, comparison-free range reduction
//     int quotients = (int)(x / TWO_PI);
//     x = x - ((float)quotients * TWO_PI);
    
//     if (float_gt(x, PI))  x -= TWO_PI;
//     if (float_lt(x, -PI)) x += TWO_PI;

//     float term = x;
//     float sum = x;
//     float x_squared = x * x;
    
//     // Increased to 17 for absolute single-precision precision limits
//     for (int i = 3; i <= 17; i += 2) { 
//         term = -term * x_squared / (float)(i * (i - 1));
//         sum += term;
//     }
//     return sum;
// }

// // 4. Standalone High-Precision Natural Logarithm Helper
// float custom_ln(float x) {
//     if (float_lt(x, 0.0f) || float_eq(x, 0.0f)) return -1.0f;
    
//     float e_count = 0.0f;
//     while (float_gt(x, 2.0f)) {
//         x /= 2.71828182f;
//         e_count += 1.0f;
//     }
//     while (float_lt(x, 0.5f)) {
//         x *= 2.71828182f;
//         e_count -= 1.0f;
//     }
    
//     float y = 0.0f;
//     for (int i = 0; i < 10; i++) { // Boosted Halley passes
//         float exp_y = 1.0f;
//         float term = 1.0f;
//         for (int j = 1; j <= 10; j++) {
//             term *= y / (float)j;
//             exp_y += term;
//         }
//         y += 2.0f * (x - exp_y) / (x + exp_y);
//     }
//     return y + e_count;
// }

// // 5. Power Function
// float custom_pow(float base, float exponent) {
//     if (float_eq(base, 0.0f)) return 0.0f;
//     if (float_eq(exponent, 0.0f)) return 1.0f;
    
//     if (float_eq(exponent, (float)(int)exponent)) {
//         int p = (int)exponent;
//         float result = 1.0f;
//         float current_product = float_lt((float)p, 0.0f) ? (1.0f / base) : base;
//         if (p < 0) p = -p;

//         while (p > 0) {
//             if (p % 2 == 1) result *= current_product;
//             current_product *= current_product;
//             p /= 2;
//         }
//         return result;
//     }

//     if (float_lt(base, 0.0f)) return -1.0f; 
//     return custom_exp(exponent * custom_ln(base)); 
// }

// // 6. Gamma Function (Bypasses the unstable sin() reflection bug)
// float custom_gamma(float x) {
//     if (float_lt(x, 0.001f)) {
//         return 30.0f; // Soft cap matching visual boundary
//     }

//     // Shift range safely from [0, 1] to the highly stable polynomial window [1, 2]
//     // Uses identity: Gamma(x) = Gamma(x + 1) / x
//     float t = x + 1.0f;
//     float z = t - 1.0f;

//     // 14th-degree minimax coefficients matching full 32-bit single precision depth
//     float c0  =  1.0000000000f;
//     float c1  = -0.5772156649f;
//     float c2  =  0.9882058914f;
//     float c3  = -0.8970569379f;
//     float c4  =  0.9182068578f;
//     float c5  = -0.7567040775f;
//     float c6  =  0.4821993946f;
//     float c7  = -0.1935278183f;
//     float c8  =  0.0358683431f;
//     float c9  = -0.0017366314f;
//     float c10 = -0.0016008585f;
//     float c11 =  0.0006965158f;
//     float c12 = -0.0001479822f;
//     float c13 =  0.0000156903f;
//     float c14 = -0.0000007802f;

//     // Horner's evaluation method
//     float gamma_t = c0 + z*(c1 + z*(c2 + z*(c3 + z*(c4 + z*(c5 + z*(c6 + z*(c7 + 
//                     z*(c8 + z*(c9 + z*(c10 + z*(c11 + z*(c12 + z*(c13 + z*c14)))))))))))));

//     return gamma_t / x;
// }

// float custom_gamma_all_range(float x) {
//     // 1. Handle exact negative integers and zero (The Poles)
//     // If x is an integer and <= 0, Gamma is undefined (Infinity)
//     if (float_eq(x, (float)(int)x) && (float_lt(x, 0.0f) || float_eq(x, 0.0f))) {
//         return 30.0f; // Soft visual cap for your graph's vertical wall
//     }

//     float factor = 1.0f;

//     // 2. Downward Range Reduction for large positive numbers (x > 2.0)
//     // Uses identity: Gamma(x) = (x-1) * Gamma(x-1)
//     while (float_gt(x, 2.0f)) {
//         x -= 1.0f;
//         factor *= x;
//     }

//     // 3. Upward Range Reduction for small or negative numbers (x < 1.0)
//     // Uses identity: Gamma(x) = Gamma(x+1) / x
//     while (float_lt(x, 1.0f)) {
//         factor /= x;
//         x += 1.0f;
//     }

//     // At this point, x is guaranteed to be perfectly inside the [1.0, 2.0] window
//     float z = x - 1.0f;

//     // 14th-degree minimax coefficients for 32-bit float precision
//     float c0  =  1.0000000000f;
//     float c1  = -0.5772156649f;
//     float c2  =  0.9882058914f;
//     float c3  = -0.8970569379f;
//     float c4  =  0.9182068578f;
//     float c5  = -0.7567040775f;
//     float c6  =  0.4821993946f;
//     float c7  = -0.1935278183f;
//     float c8  =  0.0358683431f;
//     float c9  = -0.0017366314f;
//     float c10 = -0.0016008585f;
//     float c11 =  0.0006965158f;
//     float c12 = -0.0001479822f;
//     float c13 =  0.0000156903f;
//     float c14 = -0.0000007802f;

//     // Horner's method polynomial evaluation
//     float gamma_window = c0 + z*(c1 + z*(c2 + z*(c3 + z*(c4 + z*(c5 + z*(c6 + z*(c7 + 
//                          z*(c8 + z*(c9 + z*(c10 + z*(c11 + z*(c12 + z*(c13 + z*c14)))))))))))));

//     // 4. Reconstruct the final value
//     return factor * gamma_window;
// }

float custom_gamma_all_range(float x) {
    // 1. Handle exact negative integers and zero (The Poles)
    // If x is an integer and <= 0, Gamma is undefined (Infinity)
    if ((x== (float)(int)x) && ((x< 0.0f) || x== 0.0f)) {
        return 30.0f; // Soft visual cap for your graph's vertical wall
    }

    float factor = 1.0f;

    // 2. Downward Range Reduction for large positive numbers (x > 2.0)
    // Uses identity: Gamma(x) = (x-1) * Gamma(x-1)
    while ((x> 2.0f)) {
        x -= 1.0f;
        factor *= x;
    }

    // 3. Upward Range Reduction for small or negative numbers (x < 1.0)
    // Uses identity: Gamma(x) = Gamma(x+1) / x
    while (x< 1.0f) {
        factor /= x;
        x += 1.0f;
    }

    // At this point, x is guaranteed to be perfectly inside the [1.0, 2.0] window
    float z = x - 1.0f;

    // 14th-degree minimax coefficients for 32-bit float precision
    float c0  =  1.0000000000f;
    float c1  = -0.5772156649f;
    float c2  =  0.9882058914f;
    float c3  = -0.8970569379f;
    float c4  =  0.9182068578f;
    float c5  = -0.7567040775f;
    float c6  =  0.4821993946f;
    float c7  = -0.1935278183f;
    float c8  =  0.0358683431f;
    float c9  = -0.0017366314f;
    float c10 = -0.0016008585f;
    float c11 =  0.0006965158f;
    float c12 = -0.0001479822f;
    float c13 =  0.0000156903f;
    float c14 = -0.0000007802f;

    // Horner's method polynomial evaluation
    float gamma_window = c0 + z*(c1 + z*(c2 + z*(c3 + z*(c4 + z*(c5 + z*(c6 + z*(c7 + 
                         z*(c8 + z*(c9 + z*(c10 + z*(c11 + z*(c12 + z*(c13 + z*c14)))))))))))));

    // 4. Reconstruct the final value
    return factor * gamma_window;
}


void compute(){
    float start= (float) read_cycle_counter(CYCLE_COUNTER_LOW);
    data-=4;
    uart_read(&a[0]);
    uart_read(&a[1]);
    uart_read(&a[2]);
    uart_read(&a[3]);
    input=*(float*)&a[0];
    float f=custom_gamma_all_range(input);
    float end= (float) read_cycle_counter(CYCLE_COUNTER_LOW);
    float time= end - start;
       
        uart_write((uint8_t*)&f,4);
        uart_write((uint8_t*)&time,4);
}

// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    uart_Rx_ISR();
    
    data++;
    if (data % 4==0)
    {
        state=1;
    }else{state=0;}
    
    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}


int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    input=0;
    data=0;
    // super loop :)
    while(1){  

        switch (state)
        {
        case 0:
            break;
        case 1:
        compute();
        *UART_CONTROLS |= (RX_ENABLE);
        *UART_CONTROLS &= ~(RX_ENABLE);
        enable_interrupts(interrupt_handler);
        state=0;
        break;

        default:
            break;
        }

}
return 0;
}


// function doesnt affect sp nor save return address,used to init data and to 
// run at startup, before anything else, it gets stack start from the linker script
extern int _stack_start;
__attribute__((naked, noreturn))
void __attribute__((section(".text.Reset"))) Reset(){
    
    __asm__ volatile ("la sp,_stack_start\n\t");//set sp to last memory location
    disable_interrupts();    
    uart_disable(TX_ENABLE|RX_ENABLE);
    main();
}
