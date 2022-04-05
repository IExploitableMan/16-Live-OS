@echo off
"asm/nasm/nasm.exe" -s -f bin -o ".2 out/boot.bin" boot.asm
"asm/nasm/nasm.exe" -Z ".1 log/boot.log" -f bin -o ".2 out/boot.bin" boot.asm
pause