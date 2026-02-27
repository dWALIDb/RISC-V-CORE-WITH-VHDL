//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include"utils\weights_quantized.h"
#include"utils\neural_network.h"
#include"utils\custom_instructions.h"

#define MAX_TERMS 7  //counting starts from 0 so be carefull

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


void forward_pass_quantized(const float* input, uint32_t input_size,
                  const int8_t* weights,float scale_weights, const int8_t* biases,
                  float scale_biases,float* output, uint32_t output_size)
{
    for (uint32_t i = 0; i < output_size; i++) {
        float sum = biases[i]*scale_biases;
        for (uint32_t j = 0; j < input_size; j++) {
            sum += input[j] * weights[j * output_size + i]*scale_weights;
        }
        output[i] = sum;
    }
}

void tanh_activation_quantized(float* input,uint32_t size){
    for(uint32_t i=0;i<size;i++){
        
        if ((int32_t)input[i] < -3){input[i]=-1.0f;continue;}
        if ((int32_t)input[i] >  3){input[i]=1.0f;continue;}
        
        float x2 = input[i] * input[i];
        float x3=input[i] * (27.0f + x2) / (27.0f + 9.0f * x2);
        input[i]=x3;
    }
}


uint32_t x=0;
float l0[16], l1[16];  // outputs buffers for each layer
uint8_t a[8],m[8];
float input;
volatile uint32_t data=1,state=0;
// just incase the needed BGEU does not work
// it is working now, but i had some trouble with it before
uint32_t is_greater_equal(uint32_t rs1,uint32_t rs2){
    uint32_t res;
    __asm__ volatile (
        "sltu %0,%1,%2 \t\n"
        :"=r"(res)//outputs numbered first, then inputs 0-> end :)
        :"r"(rs1),"r"(rs2)
    );
    return (res ^ 0x00000001);
}



float factorial(uint32_t n){
    float fact=1.0f;
    for (int i = 1; i < (n+1); i++)
    {
       fact=fact*(float)i;
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

// computing ANN approximation and multiple terms of taylor series approximation
// values are sent interleaved,for example
// ann values are always the last to be sent, meaning starting from index MAX_TERMS-1
// there would be an ANN value sent each MAX_TERM (i*max_term + (maxterm-1))
// MAX_TERM=7 means you find ann values at indeces (6,13,20...)
void compute(){
        data-=4;
        uart_read(&a[0]);
        uart_read(&a[1]);
        uart_read(&a[2]);
        uart_read(&a[3]);
        input=*(float*)&a[0];
        
        forward_pass_quantized(&input, 1, quantized_W0,W0_scale, quantized_B0,B0_scale, l0, 8);
        tanh_activation_quantized(l0, 8);
    
        // uart_write("layer2\n\r",9);
        forward_pass_quantized(l0, 8, quantized_W1,W1_scale, quantized_B1,B1_scale, l1, 16);
        tanh_activation_quantized(l1, 16);
    
        // uart_write("layer3\n\r",9);
        forward_pass_quantized(l1, 16, quantized_W2,W2_scale, quantized_B2,B2_scale, l0, 16);
        tanh_activation_quantized(l0, 16);
    
        // uart_write("layer4\n\r",9);
        forward_pass_quantized(l0, 16, quantized_W3,W3_scale, quantized_B3,B3_scale, l1, 8);
        tanh_activation_quantized(l1, 8);
    
        // Layer 4 (final output)
        forward_pass_quantized(l1, 8, quantized_W4,W4_scale, quantized_B4,B4_scale, l0, 1);

        for (uint8_t j = 1; j < MAX_TERMS; j++)
        {
            l0[1]=1.0f;
            l1[0]=1.0f;
            float f;
            for (int i = 1; i < j; i++)
            {
                f=factorial(2*i);
                l0[1]=mult(input,(2*i));            
                if (i % 2 == 1) l0[1]*=-1.0f;
                l1[0]+= (l0[1]/(f));
            }
            uart_write((uint8_t*)&l1[0],4);//l1 has value of TAYLOR N=0,1,,,MAX_TERMS
        }
        // we send taylor series vales first,then send ann last.
        uart_write((uint8_t*)&l0[0],4);//ANN is the last value MUST KEEP IN MIND
        uart_write("\n\r",2);
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
