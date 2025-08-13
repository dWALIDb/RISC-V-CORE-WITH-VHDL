riscv-none-elf-gcc -Wl,-Map=first.map  -I%CD%/utils/ -T newlinker.ld -o first.elf *.c -O1 -mabi=ilp32f -march=rv32imf -nostartfiles 
riscv-none-elf-objcopy -O binary first.elf first.bin 
riscv-none-elf-objdump -d first.elf > first.asm
flipper.exe first.bin 16384 

@REM -ffunction-sections -fdata-sections -Wl,--gc-sections