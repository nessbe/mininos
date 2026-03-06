// include/drivers/vga/vga.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef VGA_H
#define VGA_H

#include <stdint.h>

#ifdef __cplusplus
extern "C"
{
#endif

#define VGA_ADDRESS ((volatile uint16_t *)0xB8000)
#define VGA_WIDTH   80
#define VGA_HEIGHT  25
#define VGA_SIZE    (VGA_WIDTH * VGA_HEIGHT)

#ifdef __cplusplus
}
#endif

#endif
