# src/boot/CMakeLists.txt
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set(BOOT_DIR "${SRC_DIR}/boot")

enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)

file(
	GLOB_RECURSE BOOT_SOURCES
	CONFIGURE_DEPENDS "${BOOT_DIR}/*.asm"
)

set(BOOT_OBJECTS)

foreach(BOOT_SOURCE ${BOOT_SOURCES})
	file(
		RELATIVE_PATH RELATIVE_PATH_TO_ROOT
		"${ROOT_DIR}"
		"${BOOT_SOURCE}"
	)

	file(
		RELATIVE_PATH RELATIVE_PATH_TO_SRC
		"${SRC_DIR}"
		"${BOOT_SOURCE}"
	)

	get_filename_component(FILE_DIR "${RELATIVE_PATH_TO_SRC}" DIRECTORY)
	get_filename_component(FILE_WE "${RELATIVE_PATH_TO_SRC}" NAME_WE)

	set(
		BOOT_OBJECT
		"${BIN_DIR}/${FILE_DIR}/${FILE_WE}.bin"
	)

	get_filename_component(OUT_DIR "${BOOT_OBJECT}" DIRECTORY)

	add_custom_command(
		OUTPUT "${BOOT_OBJECT}"
		COMMAND "${CMAKE_COMMAND}" -E make_directory "${OUT_DIR}"
		COMMAND nasm -f bin "${BOOT_SOURCE}" -o "${BOOT_OBJECT}"
		DEPENDS "${BOOT_SOURCE}"
		COMMENT "Assembling ${RELATIVE_PATH_TO_ROOT}"
		VERBATIM
	)

	list(APPEND BOOT_OBJECTS "${BOOT_OBJECT}")
endforeach()

add_custom_target(boot ALL DEPENDS ${BOOT_OBJECTS})
