; src/boot/protected_mode.inc
;
; Copyright (c) 2026-Present Nessbe
;
; This file is licensed under the terms specified in the
; LICENSE file located at the root of this repository.

STACK_BASE  equ 0x9C00
VGA_ADDRESS equ 0xB8000
VGA_STYLE   equ 0x07

protected_mode:
	cli
	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp CODE_SEGMENT:pm_main

[bits 32]
pm_main:
	mov ax, DATA_SEGMENT
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov ebp, STACK_BASE
	mov esp, ebp

	in al, 0x92
	or al, 2
	out 0x92, al

	jmp CODE_SEGMENT:KERNEL_START_ADDRESS
