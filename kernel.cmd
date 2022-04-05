@echo off
"asm/nasm/nasm.exe" -s -f bin -o ".2 out/kernel.bin" kernel.asm
"asm/nasm/nasm.exe" -Z ".1 log/kernel.log" -f bin -o ".2 out/kernel.bin" kernel.asm
pause