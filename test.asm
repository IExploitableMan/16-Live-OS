org 7C00h
call clear

loop:
	mov bl, 0000_1111b
	mov cx, invite_string_end - invite_string
	mov dl, 00h
	mov bp, invite_string
	call print

	jmp loop

clear:
	mov ah, 00h
	mov al, 03h
	int 10h
	ret

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
	ret

is_it_last_line:
	mov ah, 18h
	cmp [line_number], ah
	je _yes
	jmp _end

	_yes:
		mov ah, 00h
		mov [line_number], ah

	call clear

	_end:
		ret

invite_string db ">>> ", 0
invite_string_end:

line_number db 0
input_char db 0

times 510 - ($ - $$) db 0
db 0x55, 0xAA