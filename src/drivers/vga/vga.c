// src/drivers/vga/vga.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#include <vga/vga.h>

#include <string.h>

#define VGA_ADDRESS ((volatile uint16_t *)0xB8000)
#define VGA_WIDTH   80
#define VGA_HEIGHT  25
#define VGA_SIZE    (VGA_WIDTH * VGA_HEIGHT)

static size_t __vga_pos__ = 0;
static uint8_t __vga_attr__ = 0x0F;

bool vga_out_of_bounds(size_t idx)
{
	return idx >= VGA_SIZE;
}

errcode_t vga_read(size_t idx, uint8_t *c, uint8_t *attr)
{
	if (vga_out_of_bounds(idx))
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
	if (vga_out_of_bounds(idx))
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

bool vga_out_of_bounds_xy(size_t x, size_t y)
{
	return vga_out_of_bounds(vga_idx(x, y));
}

errcode_t vga_read_xy(size_t x, size_t y, uint8_t *c, uint8_t *attr)
{
	return vga_read(vga_idx(x, y), c, attr);
}

errcode_t vga_write_xy(size_t x, size_t y, uint8_t c, uint8_t attr)
{
	return vga_write(vga_idx(x, y), c, attr);
}

errcode_t vga_fill(size_t x, size_t y, size_t w, size_t h, uint8_t c, uint8_t attr)
{
	if (vga_out_of_bounds_xy(x, y))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	if (vga_out_of_bounds_xy(x + w, y + h))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	for (size_t j = y; j < y + h; j++)
	{
		for (size_t i = x; i < x + w; i++)
		{
			errcode_t err = vga_write_xy(i, j, c, attr);

			if (err != ERRCODE_OK)
			{
				return err;
			}
		}
	}

	return ERRCODE_OK;
}

void vga_clear(uint8_t c, uint8_t attr)
{
	vga_fill(0, 0, VGA_WIDTH - 1, VGA_HEIGHT - 1, c, attr);
}

void vga_set_attr(uint8_t attr)
{
	__vga_attr__ = attr;
}

uint8_t vga_get_attr()
{
	return __vga_attr__;
}

size_t vga_pos(void)
{
	return __vga_pos__;
}

errcode_t vga_seek(size_t idx)
{
	if (vga_out_of_bounds(idx))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	__vga_pos__ = idx;

	return ERRCODE_OK;
}

errcode_t vga_seek_xy(size_t x, size_t y)
{
	return vga_seek(vga_idx(x, y));
}

errcode_t vga_skip(size_t count)
{
	size_t new_pos = __vga_pos__ + count;

	if (vga_out_of_bounds(new_pos))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	__vga_pos__ = new_pos;
	return ERRCODE_OK;
}

errcode_t vga_newline(void)
{
	size_t line_count = (__vga_pos__ + VGA_WIDTH) / VGA_WIDTH;
	size_t new_pos = VGA_WIDTH * line_count;

	if (vga_out_of_bounds(new_pos))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	__vga_pos__ = new_pos;
	return ERRCODE_OK;
}

errcode_t vga_peek(uint8_t *c, uint8_t *attr)
{
	return vga_read(__vga_pos__, c, attr);
}

errcode_t vga_get(uint8_t *c, uint8_t *attr)
{
	errcode_t err = vga_peek(c, attr);

	if (err != ERRCODE_OK)
	{
		return err;
	}

	return vga_skip(1);;
}

errcode_t vga_set(uint8_t c)
{
	return vga_write(__vga_pos__, c, __vga_attr__);
}

errcode_t vga_putc(uint8_t c)
{
	if (c == '\n')
	{
		return vga_newline();
	}

	errcode_t err = vga_set(c);

	if (err != ERRCODE_OK)
	{
		return err;
	}

	return vga_skip(1);
}

errcode_t vga_puts(const char *str)
{
	size_t len = strlen(str);

	for (size_t i = 0; i < len; i++)
	{
		errcode_t err = vga_putc((uint8_t)str[i]);

		if (err != ERRCODE_OK)
		{
			return err;
		}
	}

	return ERRCODE_OK;
}
