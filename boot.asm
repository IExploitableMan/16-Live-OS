org 7C00h
cli              ;Запрещаем прерывания (чтобы ничего не отвлекало)
xor ax, ax       ;Обнуляем регистр ax
mov ds, ax       ;Настраиваем dataSegment на нулевой адрес
mov es, ax       ;Настраиваем сегмент es на нулевой адрес
mov ss, ax       ;Настраиваем StackSegment на нулевой адрес
mov sp, 07C00h   ;Указываем на текущую вершину стека
sti              ;Запрещаем прерывания

;Очищаем экран
mov ax, 3
int 10h

mov ah, 2h
mov dh, 0
mov dl, 0
xor bh, bh
int 10h

jmp $
times 510 - ($ - $$) db 0
db 0x55, 0xAA