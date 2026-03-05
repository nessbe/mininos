; src/boot/load_kernel.inc
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

KERNEL_LOAD_SEGMENT  equ 0x1000
KERNEL_LOAD_OFFSET   equ 0x0000
KERNEL_START_ADDRESS equ 0x10000
KERNEL_SECTOR_START  equ 2
KERNEL_SECTOR_COUNT  equ 1

load_kernel:
	mov ax, KERNEL_LOAD_SEGMENT
	mov es, ax
	mov bx, KERNEL_LOAD_OFFSET

	mov ah, 0x02
	mov al, KERNEL_SECTOR_COUNT
	mov ch, 0x00
	mov dh, 0x00
	mov cl, KERNEL_SECTOR_START
	mov dl, [boot_drive]

	int 0x13
	jc .disk_error

	mov si, kernel_load_success_message
	call print_string

	ret

.disk_error:
	mov si, disk_error_message
	call print_string
	jmp halt

kernel_load_success_message db 'Kernel loaded successfully', 0
disk_error_message          db 'Disk read error', 0
