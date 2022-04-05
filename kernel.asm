[BITS 16]
[ORG 7e00h]

call clear

loop:
	; строка инпута
	mov bl, 02h
	mov cx, invite_string_end - invite_string
	mov dl, 00h
	mov bp, invite_string
	call print

	call get_input

	mov ah, 1
	call return


	; команды
	mov ah, [input] ; что-то тут не так...
	cmp ah, [help_command_name] ; не срабатывает условие
	je cmd_help

	jmp loop

	cmd_help:
		mov cx, help_command_string_end - help_command_string
		mov dl, 00h
		mov bp, help_command_string
		call print

		mov ah, 3
		call return

		jmp loop

	cmd_shut:
		hlt ;интересно чо буит с компом если так завершить ос?))
		ret ;зависнет(

;ниже заморозки можно разместить данные...
invite_string db ">>> "
invite_string_end: ;чтобы найти длинну строки

line_number db 0

help_command_name db "help"
help_command_string db "List of CMDs", 13, 10, "h => shows this message", 13, 10, "s => shutdown your system", 0
help_command_string_end:

input db ""
input_end:

;...и функции
print:
	call is_it_last_line
	mov ah, 13h
	mov al, 01h
	mov bh, 00h
	;bl - цвет; пример => 02h
	;cx - длина строки
	mov dh, [line_number]
	;dl - колонка
	push cs
	pop es
	;bp - строка
	int 10h
	ret

return:
	add [line_number], ah
	ret

is_it_last_line:
	mov ah, 18h
	cmp [line_number], ah
	jne _end

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

get_input:
	mov bx, 0             ; инициализируем bx как индекс для хранения ввода

input_processing:
	mov ah, 00h           ; параметр для вызова 0x16
	int 16h               ; получаем ASCII код

	cmp al, 0dh           ; если нажали enter
	je check_the_input    ; то вызываем функцию, в которой проверяем

	cmp al, 08h           ; если нажали backspace
	je backspace_pressed

	mov ah, 0eh           ; во всех противных случаях - просто печатаем
	int 10h               ; очередной символ из ввода

	mov [input+bx], al    ; и сохраняем его в буффер ввода
	inc bx                ; увеличиваем индекс

	cmp bx, 32            ; если input переполнен
	je check_the_input    ; то ведем себя так, будто был нажат enter

	jmp input_processing  ; и идем заново

backspace_pressed:
	cmp bx, 0             ; если backspace нажат, но input пуст, то
	je input_processing   ; ничего не делаем

	mov ah, 0x0e          ; печатаем backspace. это значит, что каретка
	int 10h               ; просто передвинется назад, но сам символ не сотрется

	mov al, ' '           ; поэтому печатаем пробел на том месте, куда
	int 10h               ; встала каретка

	mov al, 08h           ; пробел передвинет каретку в изначальное положение
	int 10h               ; поэтому еще раз печатаем backspace

	dec bx
	mov byte [input+bx], 0; и убираем из input последний символ

	jmp input_processing  ; и возвращаемся обратно

check_the_input:
	cmp bx, 0             ; если enter нажат, но input пуст
	je input_processing
	ret

read_key:
	mov ah, 00h
	int 16h
	ret

times 510 - ($ - $$) db 0
; db 0x55, 0xAAs