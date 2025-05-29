MEMORY
{
  FLASH (rx)   : ORIGIN = 0x00000000, LENGTH = 256
  RAM   (rw)   : ORIGIN = 0x00000000, LENGTH = 256
}

SECTIONS
{
  . = ORIGIN(FLASH);   /* Start from the beginning of FLASH memory */

  .text :
  {
    KEEP(*(.text.main))  /* Keep the main function at the beginning */
    *(.text*)            /* Then, include all other text (code) */
  } > FLASH

  .rodata : { *(.rodata*) } > FLASH  /* Read-only data goes into FLASH */
  
  .data : { *(.data*) } > RAM   /* Initialized data goes into RAM */
  
  .bss  : { *(.bss*)  } > RAM   /* Uninitialized data goes into RAM */
  /* Align everything to 4 bytes (word-aligned) */
  . = ALIGN(4);
}
