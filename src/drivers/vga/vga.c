// src/drivers/vga/vga.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#include <vga/vga.h>

errcode_t vga_get(size_t idx, uint8_t *c, uint8_t *attr)
{
	if (idx >= VGA_SIZE)
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	uint16_t value = VGA_ADDRESS[idx];

	if (c != NULL)
	{
		*c = (uint8_t)value;
	}

	if (attr != NULL)
	{
		*attr = (uint8_t)(value >> 8);
	}

	return ERRCODE_OK;
}

errcode_t vga_set(size_t idx, uint8_t c, uint8_t attr)
{
	if (idx >= VGA_SIZE)
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	VGA_ADDRESS[idx] = ((uint16_t)attr << 8) | c;

	return ERRCODE_OK;
}
