# targets/disk/meson.build
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

disk = custom_target(
	'disk.img',
	output: 'disk.img',
	input: [ bootloader, kernel_bin ],
	command: [
		'cat',
		'@INPUT0@',
		'@INPUT1@',
	],
	capture: true,
	build_by_default: true
)
