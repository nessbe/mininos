# kernel/meson.build
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

linker_file = files('linker.ld')

kernel_elf = executable(
	'kernel.elf',
	kernel_sources,
	link_args: [
		'-T', linker_file[0].full_path()
	],
	link_depends: linker_file,
	dependencies: [
		kernel_flags,
		kernel_include,
		libc_dep,
		driver_deps,
		driver_include
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
		'bs=' + SECTOR_SIZE.to_string(),
		'count=' + KERNEL_SECTOR_COUNT.to_string(),
		'conv=sync'
	],
	build_by_default: true
)
