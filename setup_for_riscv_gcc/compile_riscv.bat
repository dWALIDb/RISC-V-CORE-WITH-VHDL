riscv-none-elf-gcc -T newlinker.ld -o newfirst.elf first.c -O1 -march=rv32imf -nostartfiles -nostdlib
riscv-none-elf-objcopy -O binary newfirst.elf newfirst.bin 
riscv-none-elf-objdump -d newfirst.elf > newfirst.asm
flipper.exe