# src/drivers/vga/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

vga_sources = files(
	'vga.c'
)

vga_lib = static_library(
	'vga',
	vga_sources,
	dependencies: [
		driver_flags,
		driver_include,
		libc_include,
		kernel_include
	]
)

vga_dep = declare_dependency(
	link_with: vga_lib
)
