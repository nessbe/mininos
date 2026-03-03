; src/boot/gdt.nasm
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

gdt_start:

gdt_null:
	dd 0x00000000
	dd 0x00000000

gdt_code:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 0b10011011
	db 0b11011111
	db 0x00

gdt_data:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 0b10010011
	db 0b11011111
	db 0x00

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
