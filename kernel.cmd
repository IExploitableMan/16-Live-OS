@echo off
"asm/nasm/nasm.exe" -Z ".1 log/kernel.log" -f bin -o ".2 out/kernel.mbr" kernel.asm
type ".1 log\kernel.log"|more
pause