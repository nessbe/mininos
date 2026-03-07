# src/kernel/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

SECTOR_SIZE = 512
KERNEL_SECTOR_COUNT = 16

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
	include_directories: kernel_include,
	dependencies: [
		kernel_flags,
		libc_dep
	]
)

kernel_raw = custom_target(
	'kernel.raw',
	input: kernel_elf,
	output: 'kernel.raw',
	command: [
		objcopy,
		'-O', 'binary',
		'@INPUT@',
		'@OUTPUT@'
	],
	build_by_default: true
)

kernel_bin = custom_target(
	'kernel.bin',
	input: kernel_raw,
	output: 'kernel.bin',
	command: [
		'dd',
		'if=@INPUT@',
		'of=@OUTPUT@',
		'bs=@0@'.format(SECTOR_SIZE),
		'count=@0@'.format(KERNEL_SECTOR_COUNT),
		'conv=sync'
	],
	build_by_default: true
)
