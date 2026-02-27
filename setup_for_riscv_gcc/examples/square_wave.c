// THIS CODE GENERATES COSINE VALUES 
// ACCORDING TO STEP, THIS STEP IS DECIDED USING SAMPLING FREQUENCY 
// AND DESIRED OUTPUT FREQUENY OF GENERATED COSINE
// MASTER(PC) MUST SEND 1 BYTE OVER UART
// CPU RESPONDS WITH 4 BYTES FOR THE OUTPUT AND ANOTHER 4 BYTES FOR THE CYCLES TAKEN
// THE THEIR TYPE IS FLOAT
// SEND BYTE EACH TIME TO TRIGGER CPU :)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include "utils\weights_quantized.h"
#include "utils\neural_network.h"
// PI usefull for additions and trigonometric calculations
#define TWO_PI (6.283185f)
#define PI (3.141592f)
#define FS (8000.0f)
#define F0 (440.0f)
#define STEP (float)(0.3455749f)
#define FOURIER_SERIES_TERMS 10
// negative PI usefull when subtracting :), because i have no fsub inst
float NEGATIVE_TWO_PI= (-6.283185f);
float NEGATIVE_PI =(-3.141592f);



uint32_t cycles_start=0;
uint32_t cycles_end=0;
float cycles_delay=0;
uint8_t a[8];
uint8_t res=0;
float input;
volatile uint32_t data=0,state=0;


// delay in ms
void delay(uint32_t ms){
    // 4 instructions per iteration each taking 4 cycles
    // then 1000 for a delay in ms ;)
    for (uint32_t y=0 ; y<ms ;y++)
        for (uint32_t i = 0; i < (CPU_FREQ/20)/1000; i++){
            __asm__ volatile(
                "nop \n\t"
                "nop \n\t"
                "nop \n\t"
                "nop \n\t"
            );
        }
}

float __attribute__((noinline)) factorial(uint32_t n){
    float fact=1.0f;
    for (int i = 1; i < (n+1); i++)
    {
       fact=fact*i;
    }
    return fact;
}

float __attribute__((noinline))  mult(float num,int pow){
    float prod=num;
    for (int i = 1; i < pow; i++)
    {
        prod*=num;
    }
    return prod;
}

// must be generated with prologue and epilogue in order to not lose addressed inside ISR
void __attribute__((noinline)) interrupt_handler(){
    uart_Rx_ISR();
    uart_read(&res);
    data++;
    if (data % 2==1)
    {
        state=1;
    }else{state=0;}
       
    *UART_CONTROLS |= (RX_ENABLE);
    *UART_CONTROLS &= ~(RX_ENABLE);
    enable_interrupts(interrupt_handler);
}

float __attribute__((noinline)) fmodulo_TWO_PI(float in){
    // input might be negative, detect and 
    // force positive
    int32_t multiples;
    float mod;
    multiples=*(int32_t*)(float*)&in;
    if ((multiples & 0x80000000)!=0){
        multiples &=(~0x80000000);
        in=*(float*)(int32_t*)&multiples;
    }
    // i dont have fsub so i must multiply by negative PI
    multiples=(int32_t) (in/(TWO_PI));
    mod=in + (((float)multiples) * NEGATIVE_TWO_PI);
    return (mod);
}

// this cosine function proides very precise calculation along [-PI , PI]
// uses 6 terms TAYLOR SERIES APPROXIMATION 
float l0[16], l1[16];  // outputs buffers for each layer
float my_cosine(float in){
    float ini;
    // normalize the input to [-PI , PI]
    ini=fmodulo_TWO_PI(in);
    ini+=(NEGATIVE_PI);
    float af=1.0f;
    float res=1.0f;
    float f=0;
    for (int i = 1; i < 6; i++)
    {
        f=factorial(2*i);
        af=mult(ini,(2*i));      
        if (i % 2 == 1) af*=-1.0f;
        res+= (af/(f));
    }
    return res;
    }
// sine is just cosine shifter by PI/2 :)
float my_sine(float in){
    in+=(PI/2.0f);
    float result=my_cosine(in);
    return result;
} 

float fourier_series[(uint32_t)(FOURIER_SERIES_TERMS/2)];
// formula for square waves 
// (4/PI) *sum of odd multiples(sin(nt)/n) 

void compute(){
    input_data((uint8_t*)cycles_start,0,WORD);
    cycles_start=*(uint32_t*)0x00000000;
    // this represents the calculation of odd multiples of (sin(nt)/n)

    for (int i = 1; i < FOURIER_SERIES_TERMS; i+=2)
    {
        float wt=input * (float)i;
        fourier_series[(int)(i/2)]=(my_sine(wt)/(float)i);
    }
    // debug
    // uart_write("\n\r",2);
    // for (int i = 1; i < FOURIER_SERIES_TERMS; i+=2)
    // {
    //     print_float(fourier_series[(int)(i/2)]);
    //     uart_write("\n\r",2);
    // }
    
    
    // this represents the sum and the 4/PI factor
    float sum=0.1f;
    for (int i = 1; i < FOURIER_SERIES_TERMS; i+=2)
    {
        sum+=fourier_series[(int)(i/2)];
    }
    sum*=(float)(4.0f/PI);
    // debug
    // uart_write("\n\r",2);
    // print_float(sum);
    // uart_write("\n\r",2);

    input_data((uint8_t*)cycles_end,0,WORD);
    cycles_end=*(uint32_t*)0x00000000;
    cycles_delay=(float)(cycles_end-cycles_start);
    uart_write((uint8_t*)&sum,4);
    uart_write((uint8_t*)&cycles_delay,4);
    input+=STEP;    
}
int main() {
    
    uart_enable(TX_ENABLE|RX_ENABLE);
    enable_interrupts(interrupt_handler);
    uart_write("main\n\r",7);
    // must not be 0, else you get weird behaviour :)
    input=0.1f;
    data=0;
    res=0;
    output_data((uint8_t*)&data,0,WORD);
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
        data=0;
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