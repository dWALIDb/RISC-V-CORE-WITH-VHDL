riscv-none-elf-gcc -Wl,-Map=first.map -fdata-sections -ffunction-sections -Wl,--gc-sections -DITERATIONS=2000 -DPERFORMANCE_RUN=1 -I%CD%/ -IC:\Users\DELL\Desktop\master_proj\C_python_setp\utils -T newlinker.ld -o first.elf %CD%\*.c C:\Users\DELL\Desktop\master_proj\C_python_setp\uart.c C:\Users\DELL\Desktop\master_proj\C_python_setp\circular_buffer.c -O2 -mabi=ilp32f -march=rv32imf -nostartfiles 
riscv-none-elf-objcopy -O binary first.elf first.bin 
riscv-none-elf-objdump -d first.elf > first.asm
C:\Users\DELL\Desktop\master_proj\C_python_setp\flipper.exe first.bin 16384  
move "C:\Users\DELL\Desktop\master_proj\C_python_setp\CoreMark_BENCHMARK\barebones\mif_0.mif" "C:\Users\DELL\Desktop\master_proj\C_python_setp\"