@echo off
start nasm/nasm.exe -f elf32 -o boot.bin boot.asm
copy boot.bin boot.mbr
pause