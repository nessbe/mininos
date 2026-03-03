# src/boot/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

bootloader = custom_target(
	'bootloader',
	input: 'bootloader.asm',
	output: 'bootloader.bin',
	command: [
		[ nasm ] + nasm_binary_flags + [ '@INPUT@', '-o', '@OUTPUT@' ]
	],
	build_by_default: true
)
