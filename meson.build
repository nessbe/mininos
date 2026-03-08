# meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

project(
	'mininos',
	[
		'c',
		'nasm'
	],
	version: '1.4.0',
	default_options: [
		'c_std=gnu11'
	]
)

libc_include_dir = include_directories('include/libc')
libc_include = declare_dependency(
	include_directories: libc_include_dir
)

kernel_include_dir = include_directories('include/kernel')
kernel_include = declare_dependency(
	include_directories: kernel_include_dir
)

subdir('meson')
subdir('src')
subdir('targets')
