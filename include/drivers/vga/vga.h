// include/drivers/vga/vga.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef VGA_H
#define VGA_H

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

errcode_t vga_get(size_t idx, uint8_t *c, uint8_t *attr);
errcode_t vga_set(size_t idx, uint8_t c, uint8_t attr);

size_t vga_idx(size_t x, size_t y);

errcode_t vga_read(size_t x, size_t y, uint8_t *c, uint8_t *attr);
errcode_t vga_write(size_t x, size_t y, uint8_t c, uint8_t attr);

#ifdef __cplusplus
}
#endif

#endif
