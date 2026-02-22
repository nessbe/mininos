# CMakeLists.txt
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

cmake_minimum_required(VERSION 3.20)

project(mininos ASM_NASM)

set(ROOT_DIR "${CMAKE_SOURCE_DIR}")
set(BUILD_DIR "${ROOT_DIR}/build")
set(BIN_DIR "${BUILD_DIR}/bin")
set(OBJ_DIR "${BUILD_DIR}/obj")

add_subdirectory(src)
