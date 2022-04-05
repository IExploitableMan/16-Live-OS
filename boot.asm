
; 0 Black   4 Red          8 Dark Grey     c Light Red
; 1 Blue    5 Magenta      9 Light Blue    d Light Magenta
; 2 Green   6 Brown        a Light Green   e Light Brown
; 3 Cyan    7 Light Grey   b Light Cyan    f – White
; пример:
;     02h (зелёный текст на чёрном фоне)
;     f0h (чёрный текст на белом фоне)

; resb - резервирование байтов
; [] - получить значение
; $al - ссылка на идентификатор 
; $ вычисляет позицию начала строки
; $$ определяет начало текущей секции (сегмента)

; H L X - Registers
; S - Segments
; P I - Pointers
;      +----+----+----+----+----+----+
;      |  8 бит  |       16 бит      |
;      +----+----+----+----+----+----+
;      |  H |  L |  X |  S |  P |  I |
; +----+----+----+----+----+----+----+
; | A  | AH | AL | AX |    |    |    |
; +----+----+----+----+----+----+----+
; | B  | BH | BL | BX |    | BP |    |
; +----+----+----+----+----+----+----+
; | C  | CH | CL | CX | CS |    |    |
; +----+----+----+----+----+----+----+
; | D  | DH | DL | DX | DS |    | DI |
; +----+----+----+----+----+----+----+
; | E  |    |    |    | ES |    |    |
; +----+----+----+----+----+----+----+
; | F  |    |    |    | FS |    |    |
; +----+----+----+----+----+----+----+
; | G  |    |    |    | GS |    |    |
; +----+----+----+----+----+----+----+
; | S  |    |    |    | SS | SP | SI |
; +----+----+----+----+----+----+----+

[BITS 16]
[ORG 7c00h]

xor ax, ax    ; make sure ds is set to 0
mov ds, ax
cld
; start putting in values:
mov ah, 2h    ; int13h function 2
mov al, 63    ; we want to read 63 sectors
mov ch, 0     ; from cylinder number 0
mov cl, 2     ; the sector number 2 - second sector (starts from 1, not 0)
mov dh, 0     ; head number 0
xor bx, bx    
mov es, bx    ; es should be 0
mov bx, 7e00h ; 512bytes from origin address 7c00h
int 13h
jmp 7e00h     ; jump to the next sector

times 510 - ($ - $$) db 0 
db 0x55, 0xAA