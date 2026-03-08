// include/libc/string.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef STRING_H
#define STRING_H

#include <stddef.h>

#ifdef __cplusplus
extern "C"
{
#endif

size_t strlen(const char *str);
char *strcpy(char *dest, const char *src);
char *strcat(char *dest, const char *src);

#ifdef __cplusplus
}
#endif

#endif
