; File:       src/boot/bootloader.asm
; Project:    MininOS
; Repository: https://github.com/nessbe/mininos
;
; Copyright (c) 2026-Present Nessbe
; This file is part of the MininOS project and is licensed
; under the terms specified in the LICENSE file located at the
; root of this repository.
;
; Unless required by applicable law or agreed to in writing,
; the software is distributed on an "AS IS" BASIS, WITHOUT
; WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the LICENSE file for details.

[bits 16]    ; Generate 16-bit code (real mode)
[org 0x7c00] ; Inform the assembler that the code is assumed to be loaded at 0x7C00

start:
	cli             ; Disable maskable interrupts
	xor ax, ax      ; AX = 0
	mov ds, ax      ; Initialize data segment
	mov es, ax      ; Initialize extra segment
	mov ss, ax      ; Initialize stack segment
	mov sp, 0x7c00  ; Initialize stack pointer (stack grows downward below the bootloader)
	sti             ; Re-enable interrupts

	cld             ; Ensure string instructions increment SI (DF = 0)
	mov si, message ; Load pointer to null-terminated string into SI

.print_char:
	lodsb           ; AL = [DS:SI], SI++
	cmp al, 0       ; Check for null terminator
	je .done        ; If AL == 0, stop printing

	mov ah, 0x0E    ; BIOS video service: teletype output function
	mov bh, 0x00    ; Video page number (usually 0)
	mov bl, 0x07    ; Text attribute (light gray on black, if supported)
	int 0x10        ; Call BIOS video interrupt

	jmp .print_char ; Continue with next character

.done:
	; Fall through to halt loop

.halt:
	hlt             ; Halt CPU until next interrupt
	jmp .halt       ; Ensure the CPU stays halted

message db 'MininOS booted successfully', 0

times 510 - ($ - $$) db 0 ; Pad with zeros up to byte 510 of the boot sector
dw 0xAA55                 ; Boot sector signature (required by BIOS)
