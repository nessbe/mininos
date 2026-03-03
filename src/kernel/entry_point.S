# src/kernel/entry_point.S
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

.intel_syntax noprefix

.section .text
	.global _start

	_start:
		cli
		call kernel_main

	.halt:
		hlt
		jmp .halt
