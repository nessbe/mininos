; src/boot/bootloader.asm
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

[bits 16]
[org 0x7c00] ; BIOS loads boot sector at this address

start:
	cli            ; Disable interrupts
	xor ax, ax     ; AX = 0
	mov ds, ax     ; DS (Data Segment) = 0
	mov es, ax     ; ES (Extra Segment) = 0
	mov ss, ax     ; SS (Stack Segment) = 0
	mov sp, 0x7c00 ; Set stack pointer to bootloader address
	sti            ; Enable interrupts

	mov si, message

.print_char:
	lodsb     ; Load byte at DS:SI into AL, increment SI
	cmp al, 0 ; If null terminator, stop printing
	je .hang

	mov ah, 0x0e ; BIOS teletype function
	mov bh, 0x00 ; Page number
	mov bl, 0x07 ; Text attribute (light grey on black)
	int 0x10     ; Call BIOS

	jmp .print_char

.hang:
	cli
	hlt
	jmp .hang ; Infinite loop

message db 'MininOS booted successfully', 0

times 510 - ($ - $$) db 0 ; Padding to 510 bytes
dw 0xAA55                 ; Boot signature
