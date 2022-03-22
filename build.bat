@echo off
start nasm/nasm.exe -f bin -o boot.bin boot.asm
copy boot.bin boot.mbr
pause