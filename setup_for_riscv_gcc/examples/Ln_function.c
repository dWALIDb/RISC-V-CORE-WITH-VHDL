//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)


// USE PROFILE CODE IN ORDER TO VISUALIZE 
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



float factorial(uint32_t n){
    float fact=1.0f;
    for (int i = 1; i < (n+1); i++)
    {
       fact=fact*i;
    }
    return fact;
}

float mult(float num,int pow){
    float prod=num;
    for (int i = 1; i < pow; i++)
    {
        prod*=num;
    }
    return prod;
}

float log_approxf(float x)
{
    if (float_lt( x , 0.0f) || float_eq( x , 0.0f))
        return -3.4e38f;   // Error value (approximately -FLT_MAX)

    int k = 0;

    // Normalize x to [1, 2)
    while (float_gt( x , 2.0f) || float_eq( x , 2.0f)) {
        x *= 0.5f;
        k++;
    }

    while (float_lt( x , 1.0f)) {
        x *= 2.0f;
        k--;
    }

    float z = (x - 1.0f) / (x + 1.0f);
    float z2 = z * z;

    // 5-term approximation
    float y = z
            + z * z2 / 3.0f
            + z * z2 * z2 / 5.0f
            + z * z2 * z2 * z2 / 7.0f
            + z * z2 * z2 * z2 * z2 / 9.0f;

    return 2.0f * y + k * 0.69314718f; // ln(2)
}


void compute(){
    float start= (float) read_cycle_counter(CYCLE_COUNTER_LOW);
    data-=4;
    uart_read(&a[0]);
    uart_read(&a[1]);
    uart_read(&a[2]);
    uart_read(&a[3]);
    input=*(float*)&a[0];
    float f=log_approxf(input);
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
