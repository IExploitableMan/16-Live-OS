org 7C00h

 start:
    cli              ;��������� ���������� (����� ������ �� ���������)
    xor ax, ax       ;�������� ������� ax
    mov ds, ax       ;����������� dataSegment �� ������� �����
    mov es, ax       ;����������� ������� es �� ������� �����
    mov ss, ax       ;����������� StackSegment �� ������� �����
    mov sp, 07C00h   ;��������� �� ������� ������� �����
    sti              ;��������� ����������

  ;������� �����
  mov ax, 3
  int 10h

  mov ah, 2h
  mov dh, 0
  mov dl, 0
  xor bh, bh
  int 10h

  ;�������� ������
  mov ax, 1301h
  mov bp, message
  mov cx, 12
  mov bl, 02h
  int 10h

  jmp $

message db 'Hello World!',0

times 510 - ($ - $$) db 0 ;���������� ���������� ���� ������ �� 510-�� �����
db 0x55, 0xAA ;����������� ���������