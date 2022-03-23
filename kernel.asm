;16 битный режим
[BITS 16]

;очищаем экран
call clear

loop:
	;печатаем строку приглашение
	mov bl, 0000_1111b
	mov cx, inviteString_end - inviteString
	mov dh, 0
	mov dl, 0
	mov bp, inviteString
	call print
	;TODO - считывание цифр с клавиатуры
;jmp loop

;заморозка программы
jmp $

;ниже заморозки можно разместить данные...
inviteString db ">>> ", 0
inviteString_end: ;чтобы найти длинну строки

;...и функции
print:
	mov ah, 13h
	mov al, 1
	mov bh, 0
	;bl - цвет; пример => 0000_1111b
	;cx - длина строки
	;dh - строка
	;dl - колонка
	push cs
	pop es
	;bp - строка
	int 10h
	ret

clear:
	mov ah, 0
	mov al, 13h
	int 10h
	ret