// src/kernel/kmain.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

void kmain(void)
{
	volatile char* vga = (volatile char*)0xB8000;

	vga[0] = 'O';
	vga[1] = 0x0F;

	vga[2] = 'K';
	vga[3] = 0x0F;

	while(1);
}
