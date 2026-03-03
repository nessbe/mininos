# meson/flags/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

optimization_flag = '-O0'

nasm_binary_flags = [
	'-f', 'bin',
	'-i', meson.source_root()
]

nasm_elf32_flags = [
	'-f', 'elf32',
	'-i', meson.source_root()
]

c_elf_flags = [
	'-ffreestanding',
	'-fno-stack-protector',
	'-fno-pic',
	'-m32',
	optimization_flag
]

link_elf_flags = [
	'-nostdlib',
	'-ffreestanding',
	optimization_flag
]
