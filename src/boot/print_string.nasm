; src/boot/print_string.nasm
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

print_string:

.load_char:
	lodsb
	cmp al, 0
	je .done

.print_char:
	mov ah,	0x0E
	mov bh, 0
	mov bl, 0x07

	int 0x10
	jmp .load_char

.done:
	ret
