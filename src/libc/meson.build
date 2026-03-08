# src/libc/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

libc_sources = files(
	'string.c'
)

libc = static_library(
	'c',
	libc_sources,
	c_args: c_elf_flags,
	dependencies: libc_include
)

libc_dep = declare_dependency(
	link_with: libc,
	dependencies: libc_include
)
