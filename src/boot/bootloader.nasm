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

.halt:
	hlt
	jmp .halt

times 510 - ($ - $$) db 0
dw 0xAA55
