# src/kernel/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

kernel_sources = files(
	'entry_point.S',
	'kernel_main.c'
)

kernel_elf = executable(
	'kernel.elf',
	kernel_sources,
	link_args: [
		'-T', '@0@/linker.ld'.format(meson.current_source_dir())
	],
	link_depends: 'linker.ld',
	dependencies: [
		kernel_flags,
		libc_dep
	]
)

kernel_bin = custom_target(
	'kernel.bin',
	input: kernel_elf,
	output: 'kernel.bin',
	command: [ objcopy, '-O', 'binary', '@INPUT@', '@OUTPUT@' ],
	build_by_default: true
)
