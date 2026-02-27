ENTRY(Reset)

MEMORY
{
    RAM (rwx)   : ORIGIN = 0x00000000, LENGTH = 32768 
}

/* give the stack start from the linker script */
/* change the memory regions and stack start is automatically RAM top */
PROVIDE( _stack_start = ORIGIN(RAM) + LENGTH(RAM) );

SECTIONS
{
    . = ORIGIN(RAM);
 
    .text :
    {
    . = ALIGN(4);
        *(.text.Reset*)
        *(.text*)
    . = ALIGN(4);
    }>RAM

    .rodata : {
    . = ALIGN(4);
        *(.rodata)
    . = ALIGN(4);
    }>RAM


    .data : {
    . = ALIGN(4);
        *(.data)
    . = ALIGN(4);
        }>RAM
    
    .bss : {
    . = ALIGN(4);
        *(.bss)
    . = ALIGN(4);
        }>RAM
        
    . = ALIGN(4);
}