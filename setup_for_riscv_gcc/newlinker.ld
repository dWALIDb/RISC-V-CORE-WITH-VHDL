ENTRY(Reset)

MEMORY
{
    FLASH (rx)   : ORIGIN = 0x00000000, LENGTH = 127
    RAM (rw)   : ORIGIN = 0x00000080, LENGTH = 127
}

SECTIONS
{
    . = ORIGIN(FLASH);
 
    .text :
    {
    . = ALIGN(4);
        *(.text*)
    . = ALIGN(4);
    }>FLASH

    .rodata : {
    . = ALIGN(4);
        *(.rodata)
    . = ALIGN(4);
        }>FLASH


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