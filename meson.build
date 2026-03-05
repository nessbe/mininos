# meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

project('mininos', [ 'c', 'nasm' ], default_options: [ 'c_std=gnu11' ])

libc_include = include_directories('include/libc')
driver_include = include_directories('include/drivers')

subdir('meson')
subdir('src')
subdir('targets')
