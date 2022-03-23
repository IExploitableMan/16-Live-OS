@echo off
start nasm/nasm.exe -f bin -o build/kernel.bin kernel.asm
pause