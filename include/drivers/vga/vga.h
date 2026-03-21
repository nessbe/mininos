// include/drivers/vga/vga.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef VGA_H
#define VGA_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include <errcode.h>

#ifdef __cplusplus
extern "C"
{
#endif

#define VGA_ADDRESS ((volatile uint16_t *)0xB8000)
#define VGA_WIDTH   80
#define VGA_HEIGHT  25
#define VGA_SIZE    (VGA_WIDTH * VGA_HEIGHT)

bool vga_out_of_range(size_t idx);
errcode_t vga_read(size_t idx, uint8_t *c, uint8_t *attr);
errcode_t vga_write(size_t idx, uint8_t c, uint8_t attr);

size_t vga_idx(size_t x, size_t y);

bool vga_out_of_rangep(size_t x, size_t y);
errcode_t vga_readp(size_t x, size_t y, uint8_t *c, uint8_t *attr);
errcode_t vga_writep(size_t x, size_t y, uint8_t c, uint8_t attr);

errcode_t vga_fill(size_t x, size_t y, size_t w, size_t h, uint8_t c, uint8_t attr);
void vga_clear(uint8_t c, uint8_t attr);

void vga_attr(uint8_t attr);

errcode_t vga_peek(uint8_t *c, uint8_t *attr);

errcode_t vga_get(uint8_t *c, uint8_t *attr);
errcode_t vga_set(uint8_t c);

errcode_t vga_seek(size_t idx);
errcode_t vga_seekp(size_t x, size_t y);

errcode_t vga_putc(uint8_t c);
errcode_t vga_puts(const uint8_t *str);

#ifdef __cplusplus
}
#endif

#endif
