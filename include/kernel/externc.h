// include/kernel/externc.h
//
// Copyright (c) 2026-Present Nessbe
//
// This file is licensed under the terms specified in the
// LICENSE file located at the root of this repository.

#ifndef EXTERNC_H
#define EXTERNC_H

#ifdef __cplusplus
	#define EXTERN_C_BEGIN extern "C" {
	#define EXTERN_C_END   }
#else
	#define EXTERN_C_BEGIN
	#define EXTERN_C_END
#endif

#endif
