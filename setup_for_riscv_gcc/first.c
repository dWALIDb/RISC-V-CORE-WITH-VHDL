//from what i noticed when i assign a constant that is large, assemly generates a load instruction
//that is exactly after the main function to load data so i gotta check the assembly to get where to put the data
// it also places the results after the main function crazy how advanced the compiler is :o
const char h[13]="hello worldD";
char t[13];
int  __attribute__((section(".text.main"))) main() {
    for (int i = 0; i < 13; i++)
    {
        t[i]=h[i];
    }
    
    
    __asm__ volatile (".word 0x00000008");//OUT_DATA x0,00 hex for the funzies    
    return 0;
}
// entry of program where i init stack pointer and other stuffies
// need to set sp this way (before reset) because sp starts at 0 when pc is loaded
__asm__("addi sp,zero,255");//set sp to last memory location
void Reset(){
    for (int i = 0; i < 13; i++)
    {
        t[i]=1;
    }
    main();
}
//  riscv-none-elf-gcc -T linker.ld -o first.elf first.c -O0 -march=rv32imf -nostartfiles -nostdlib
//  riscv-none-elf-objcopy -O binary first.elf first.bin 
//  riscv-none-elf-objdump -d first.elf > first.asm