@echo off
"asm/nasm/nasm.exe" -Z ".1 log/boot.log" -f bin -o ".2 out/boot.mbr" boot.asm
type ".1 log\boot.log"|more
pause