; src/boot/print_string.inc
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

CR equ 0x0D
LF equ 0x0A

print_string:

.loop:
	lodsb
	cmp al, 0
	je .newline

	mov ah, 0x0E
	mov bh, 0
	mov bl, 0x07

	int 0x10
	jmp .loop

.newline:
	mov al, CR
	mov ah, 0x0E
	int 0x10

	mov al, LF
	mov ah, 0x0E
	int 0x10

	ret
