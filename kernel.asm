;16 битный режим
[BITS 16]

;очищаем экран
call clear

loop:
	;печатаем строку приглашение
	mov bl, 0000_1111b
	mov cx, invite_string_end - invite_string
	mov dh, 00h
	mov dl, 00h
	mov bp, invite_string
	call print
	call read_key ;теперь в al есть символ


jmp loop

;заморозка программы
jmp $

;ниже заморозки можно разместить данные...
invite_string db ">>> ", 0
invite_string_end: ;чтобы найти длинну строки

line_number db 0

help_command db 86 ;h в формате ascii

;...и функции
print:
	call is_it_last_line
	mov ah, 13h
	mov al, 01h
	mov bh, 00h
	;bl - цвет; пример => 0000_1111b
	;cx - длина строки
	mov dh, [line_number]
	;dl - колонка
	push cs
	pop es
	;bp - строка
	int 10h
	mov ah, 1
	add [line_number], ah
	ret

is_it_last_line:
	mov ah, 18h
	cmp [line_number], ah
	je _yes
	jmp _end
	_yes:
	mov ah, 0
	mov [line_number], ah
	call clear
	_end:
	ret

clear:
	mov ah, 00h
	mov al, 13h
	int 10h
	ret

read_key:
	mov ah, 0h
	int 16h
	ret