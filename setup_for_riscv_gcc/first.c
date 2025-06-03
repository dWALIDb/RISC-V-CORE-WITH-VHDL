//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o

#include<stdint.h>

#define UART_BASE ((volatile unsigned char*) (0x00000200))

//custom instruction to put data into out register
void output_data(int *base,int offset);

void uart_send(const char*c,int size);

const char t[]={"Hello World"};

int main() {
    while (1)
    {
    
    uart_send((const char*)t,sizeof(t));
    while (1);
    }

return 0;
}


void output_data(int *base,int offset){
    //output x10,offset=0 but offset is added with base a0
    // first ':' output operand 
   // second ':' input operand  
   // first ':' clobbered registers 
   __asm__ volatile("mv a0,%0\n\t"
    "mv a1,%1\n\t"
    "add a0,a0,a1\n\t"
    ".word 0x00054008\n\t" 
    :
    :"r" (base), "r" (offset)
    :"a0", "a1"
);
}
// function doesnt affect sp nor save return address,used to init data and to 
// run at startup, before anything else
__attribute__((naked, noreturn))
void __attribute__((section(".text.Reset"))) Reset(){
    __asm__ volatile ("li sp,0x000003FC");//set sp to last memory location
    main();
}

void uart_send(const char* c,int size){
    int i=0;
    while (i<size)
    {
        UART_BASE[0]=(unsigned char)c[i];
        output_data(UART_BASE,0);
        i++;
    }
}
