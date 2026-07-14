//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

// you can tie a variable to a register using "register" keyword
// register int value asm("x31");   //now x31 is tied to value but can get address of it (like &value)
#include "utils\custom_instructions.h"
#include "utils\uart.h"
#include "utils/hex_to_ascii.h"
#include"utils\ann_weights2.h"
#include"utils\neural_network.h"
#include"utils\cycle_counter.h"


#define MAX_TERMS 7  //counting starts from 0 so be carefull


uint32_t x=0;
float l0[16], l1[16];  // outputs buffers for each layer
uint8_t a[8],m[8];
float input;
volatile uint32_t data=1,state=0;

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
        
        float inp=standardize_input(input,INPUT_MEAN,INPUT_SCALE);
        forward_pass(&inp, 1, W0 ,B0, l0, 4);
        tanh_activation_quantized(l0, 8);
        
        // uart_write("layer2\n\r",9);
        forward_pass(l0, 4, W1, B1, l1, 8);
        tanh_activation(l1, 16);
    
        // uart_write("layer3\n\r",9);
        forward_pass(l1, 8, W2, B2, l0, 8);
        tanh_activation(l0, 16);
    
        // uart_write("layer4\n\r",9);
        forward_pass(l0, 8, W3, B3, l1, 4);
        tanh_activation_quantized(l1, 8);
    
        // Layer 4 (final output)
        forward_pass(l1, 4, W4, B4, l0, 1);

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
