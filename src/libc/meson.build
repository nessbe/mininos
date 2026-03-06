# src/libc/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

libc_sources = []

libc = static_library(
	'c',
	libc_sources,
	include_directories: libc_include,
	c_args: c_elf_flags
)

libc_dep = declare_dependency(
	link_with: libc,
	include_directories: libc_include
)
