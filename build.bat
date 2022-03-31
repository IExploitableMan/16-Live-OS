@echo off
start nasm/nasm.exe -Z errors.log -f bin -o kernel.mbr kernel.asm
pause
