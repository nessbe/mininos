# src/drivers/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

driver_deps = []

if get_option('driver_vga')
	subdir('vga')
	driver_deps += vga_dep
endif
