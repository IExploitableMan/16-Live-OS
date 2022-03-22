[BITS 16]

;Очищаем экран
mov ax, 3
int 10h

mov ah, 2h
mov dh, 0
mov dl, 0
xor bh, bh
int 10h

%include "kernel.asm"

jmp $
times 510 - ($ - $$) db 0
db 0x55, 0xAA