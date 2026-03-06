// include/kernel/errcode.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef ERRCODE_H
#define ERRCODE_H

#include <externc.h>

EXTERN_C_BEGIN

typedef enum errcode {
	ERRCODE_OK = 0,

	ERRCODE_UNKNOWN,
	ERRCODE_UNDEFINED_BEHAVIOR,

	ERRCODE_LOGIC_ERR,
	ERRCODE_INVALID_ARG,

	ERRCODE_OVERFLOW,
	ERRCODE_UNDERFLOW,
} errcode_t;

EXTERN_C_END

#endif
