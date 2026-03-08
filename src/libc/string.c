// src/libc/string.c
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#include <string.h>

#include <stddef.h>

size_t strlen(const char *str)
{
	size_t size = 0;

	while (*str != '\0')
	{
		size++;
		str++;
	}

	return size;
}

char *strcpy(char *dest, const char *src)
{
	char* d = dest;

	while (*src != '\0')
	{
		*dest = *src;

		src++;
		dest++;
	}

	return d;
}

char *strcat(char *dest, const char *src)
{
	char* d = dest;
	size_t i = strlen(dest);

	while (*src != '\0')
	{
		dest[i] = *src;
		src++;
		i++;
	}

	return d;
}
