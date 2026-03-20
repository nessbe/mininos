// src/drivers/vga/vga.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#include <vga/vga.h>

static size_t __vga_pos__ = 0;
static uint8_t __vga_attr__ = 0x0F;

bool vga_out_of_range(size_t idx)
{
	return idx >= VGA_SIZE;
}

errcode_t vga_read(size_t idx, uint8_t *c, uint8_t *attr)
{
	if (vga_out_of_range(idx))
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

errcode_t vga_write(size_t idx, uint8_t c, uint8_t attr)
{
	if (vga_out_of_range(idx))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	VGA_ADDRESS[idx] = ((uint16_t)attr << 8) | c;

	return ERRCODE_OK;
}

size_t vga_idx(size_t x, size_t y)
{
	return y * VGA_WIDTH + x;
}

bool vga_out_of_rangep(size_t x, size_t y)
{
	return vga_out_of_range(vga_idx(x, y));
}

errcode_t vga_readp(size_t x, size_t y, uint8_t *c, uint8_t *attr)
{
	return vga_read(vga_idx(x, y), c, attr);
}

errcode_t vga_writep(size_t x, size_t y, uint8_t c, uint8_t attr)
{
	return vga_write(vga_idx(x, y), c, attr);
}

void vga_attr(uint8_t attr)
{
	__vga_attr__ = attr;
}

errcode_t vga_peek(uint8_t *c, uint8_t *attr)
{
	return vga_read(__vga_pos__, c, attr);
}

errcode_t vga_seek(size_t idx)
{
	if (vga_out_of_range(idx))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	__vga_pos__ = idx;

	return ERRCODE_OK;
}

errcode_t vga_seekp(size_t x, size_t y)
{
	return vga_seek(vga_idx(x, y));
}

errcode_t vga_get(uint8_t *c, uint8_t *attr)
{
	errcode_t err = vga_peek(c, attr);
	__vga_pos__++;
	return err;
}

errcode_t vga_set(uint8_t c)
{
	return vga_write(__vga_pos__, c, __vga_attr__);
}
