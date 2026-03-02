# src/kernel/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

kernel_sources = files(
	'entry_point.S',
	'kmain.c'
)

kernel_elf = executable(
	'kernel.elf',
	kernel_sources,
	link_args: link_elf_flags + [
		'-T', '@0@/linker.ld'.format(meson.current_source_dir())
	],
	c_args: c_elf_flags,
	link_depends: 'linker.ld'
)
