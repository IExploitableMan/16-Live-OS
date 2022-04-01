
; 0 Black
; 1 Blue
; 2 Green
; 3 Cyan
; 4 Red
; 5 Magenta
; 6 Brown
; 7 Light Grey
; 8 Dark Grey
; 9 Light Blue
; a Light Green
; b Light Cyan
; c Light Red
; d Light Magenta
; e Light Brown
; f – White
; пример: 02h
; зелёный текст на чёрном фоне

[BITS 16]

org 7C00h

mov ah, 02h

mov dl, 0     ; номер диска (0-n)
mov al, 1     ; кол-во секторов
mov cl, 1     ; номер сектора начала (1-63)
mov ch, 0     ; номер дорожки
mov dh, 0     ; номер головки
mov bx, 7E00h ; адрес буфера
int 13h

jmp 7E00h

times 510 - ($ - $$) db 0
db 0x55, 0xAA