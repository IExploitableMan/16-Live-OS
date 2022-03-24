;16 битный режим
[BITS 16]

;очищаем экран
call clear

loop:
	;печатаем строку приглашение
	mov bl, 0000_1111b
	mov cx, invite_string_end - invite_string
	mov dl, 00h
	mov bp, invite_string
	call print

	call read_key

	mov dl, invite_string_end - invite_string - 01h
	mov cx, 01h
	mov bp, input_char
	call print

	call carriage_return

	mov ah, [input_char]

	cmp ah, [help_command_key]
	je _help_command

	cmp ah, [shut_command_key]
	je _shut_command

	jmp loop

	_help_command:
		call cmd_help
		jmp loop

	_shut_command:
		call cmd_shut
		jmp loop

;ниже заморозки можно разместить данные...
invite_string db ">>> ", 0
invite_string_end: ;чтобы найти длинну строки

line_number db 0
input_char db 0

;буква команды + текст вывода
help_command_key db 104 ;h в формате ascii
help_command_string db "List of CMDs", 13, 10, "h => shows this message", 13, 10, "s => shutdown your system", 0
help_command_string_end:

shut_command_key db 115 ;s в формате ascii


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
	ret

carriage_return:
	mov ah, 01h
	add [line_number], ah
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

clear:
	mov ah, 00h
	mov al, 13h
	int 10h
	ret

read_key:
	mov ah, 00h
	int 16h
	mov [input_char], al
	ret

cmd_help:
	mov cx, help_command_string_end - help_command_string
	mov dl, 00h
	mov bp, help_command_string
	call print
	mov ah, 0
	call carriage_return
	call carriage_return
	call carriage_return
	;yes 3 lines
	ret

cmd_shut:
	hlt ;интересно чо буит с компом если так завершить ос?))
	ret