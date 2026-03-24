// src/drivers/vga/vga.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#include <vga/vga.h>

#include <string.h>

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

errcode_t vga_fill(size_t x, size_t y, size_t w, size_t h, uint8_t c, uint8_t attr)
{
	if (vga_out_of_rangep(x, y))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	if (vga_out_of_rangep(x + w, y + h))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	for (size_t j = y; j < y + h; j++)
	{
		for (size_t i = x; i < x + w; i++)
		{
			errcode_t err = vga_writep(i, j, c, attr);

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

void vga_attr(uint8_t attr)
{
	__vga_attr__ = attr;
}

errcode_t vga_peek(uint8_t *c, uint8_t *attr)
{
	return vga_read(__vga_pos__, c, attr);
}

errcode_t vga_skip()
{
	if (vga_out_of_range(__vga_pos__))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	__vga_pos__++;
	return ERRCODE_OK;
}

errcode_t vga_skipn(size_t n)
{
	for (size_t i = 0; i < n; i++)
	{
		errcode_t err = vga_skip();

		if (err != ERRCODE_OK)
		{
			return err;
		}
	}
}

errcode_t vga_skipl()
{
	if (vga_out_of_range(__vga_pos__))
	{
		return ERRCODE_OUT_OF_RANGE;
	}

	size_t line_count = (__vga_pos__ + VGA_WIDTH) / VGA_WIDTH;
	__vga_pos__ = line_count * VGA_WIDTH;

	return ERRCODE_OK;
}

errcode_t vga_skipln(size_t n)
{
	for (size_t i = 0; i < n; i++)
	{
		errcode_t err = vga_skipl();

		if (err != ERRCODE_OK)
		{
			return err;
		}
	}
}

errcode_t vga_get(uint8_t *c, uint8_t *attr)
{
	errcode_t err = vga_skip();

	if (err != ERRCODE_OK)
	{
		return err;
	}

	return vga_peek(c, attr);
}

errcode_t vga_set(uint8_t c)
{
	return vga_write(__vga_pos__, c, __vga_attr__);
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

errcode_t vga_putc(uint8_t c)
{
	if (c == '\n')
	{
		return vga_skipl();
	}

	errcode_t err = vga_set(c);

	if (err != ERRCODE_OK)
	{
		return err;
	}

	return vga_skip();
}

errcode_t vga_puts(const uint8_t *str)
{
	size_t len = strlen(str);

	for (size_t i = 0; i < len; i++)
	{
		errcode_t err = vga_putc(str[i]);

		if (err != ERRCODE_OK)
		{
			return err;
		}
	}

	return ERRCODE_OK;
}
