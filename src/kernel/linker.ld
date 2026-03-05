/*
 * src/kernel/linker.ld
 *
 * Copyright (c) 2026-Present Nessbe
 *
 * This file is licensed under the terms specified in the
 * LICENSE file located at the root of this repository.
 */

OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)

SECTIONS
{
	. = 0x10000;

	.text : ALIGN(4K)
	{
		*(.text*)
	}

	.rodata : ALIGN(4K)
	{
		*(.rodata*)
	}

	.data : ALIGN(4K)
	{
		*(.data*)
	}

	.bss : ALIGN(4K)
	{
		*(COMMON)
		*(.bss*)
	}
}
