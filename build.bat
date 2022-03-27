@echo off
start nasm/nasm.exe -f bin -o kernel.mbr kernel.asm
pause