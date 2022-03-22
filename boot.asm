[BITS 16]

mov ax, 3
int 10h

%include "kernel.asm"

jmp $
times 510 - ($ - $$) db 0
db 0x55, 0xAA