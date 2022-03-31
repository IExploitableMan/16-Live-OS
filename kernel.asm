org 7C00h

;16 битный режим
[BITS 16]

;очищаем экран
call clear

; 0 - Black
; 1 - Blue
; 2 - Green
; 3 - Cyan
; 4 - Red
; 5 - Magenta
; 6 - Brown
; 7 - Light Grey
; 8 - Dark Grey
; 9 - Light Blue
; a - Light Green
; b - Light Cyan
; c - Light Red
; d - Light Magenta
; e - Light Brown
; f – White.
; пример: 02h
; зелёный текст на чёрном фоне

loop:
	;печатаем строку приглашение
	mov bl, 02h
	mov cx, invite_string_end - invite_string
	mov dl, 00h
	mov bp, invite_string
	call print

	call read_string

	mov bl, 02h
	mov cx, string_end - string
	mov dl, invite_string_end - invite_string
	mov bp, string
	call print

	jmp loop

	call read_key

	call carriage_return

	mov ah, 68h ;h
	cmp al, ah
	je _help_command

	mov ah, 73h ;s
	cmp al, ah
	je _shut_command

	mov ah, 74h ;t
	cmp al, ah
	je _test_command

	; jmp loop

	_test_command:
		call cmd_test
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

help_command_string db "List of CMDs", 13, 10, "h => shows this message", 13, 10, "s => shutdown your system", 0
help_command_string_end:

test_command_string db "abcdefghijklmnopqrstuvwxyz", 0
test_command_string_end:

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
	mov ah, 1
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
	mov al, 03h
	int 10h
	ret

read_string:
	string db ""
	string_end:

	_loop:
		call read_key
		mov ah, 0dh ;\t (Enter)
		cmp al, ah
		je __end

		add [string], al
		jmp _loop

		__end:
			ret

read_key:
	mov ah, 00h
	int 16h
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

cmd_test:
	mov cx, test_command_string_end - test_command_string
	mov bl, 02h
	mov dl, 00h
	mov bp, test_command_string
	call print
	call carriage_return
	ret

times 510 - ($ - $$) db 0
db 0x55, 0xAA