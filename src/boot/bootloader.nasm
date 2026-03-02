; src/boot/bootloader.nasm
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

[bits 16]
[org 0x7C00]

start:
	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	sti

	mov si, message

.print_string:
	lodsb
	cmp al, 0
	je .done

	mov ah,	0x0E
	mov bh, 0
	mov bl, 0x07

	int 0x10
	jmp .print_string

.done:

.halt:
	hlt
	jmp .halt

message db 'MininOS booted successfully', 0

times 510 - ($ - $$) db 0
dw 0xAA55
