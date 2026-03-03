; src/boot/bootloader.asm
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

	mov ah, 0x00
	mov al, 0x03
	int 0x10

	mov si, boot_message
	call print_string

	jmp protected_mode

.halt:
	hlt
	jmp .halt

%include "src/boot/gdt.inc"
%include "src/boot/print_string.inc"

boot_message db 'MininOS booted successfully', 0

%include "src/boot/protected_mode.inc"

times 510 - ($ - $$) db 0
dw 0xAA55
