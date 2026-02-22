# cmake/qemu.cmake
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set(QEMU qemu-system-i386)
set(BOOT_IMAGE "${BIN_DIR}/boot/bootloader.bin")

add_custom_target(
	run
	COMMAND ${QEMU} -drive format=raw,file=${BOOT_IMAGE}
	DEPENDS build/bin/boot/bootloader.bin
	COMMENT "Running QEMU"
	VERBATIM
)
