# File:       make/config.mk
# Project:    MininOS
# Repository: https://github.com/nessbe/mininos
#
# Copyright (c) 2026-Present Nessbe
# This file is part of the MininOS project and is licensed
# under the terms specified in the LICENSE file located at the
# root of this repository.
#
# Unless required by applicable law or agreed to in writing,
# the software is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the LICENSE file for details.

MODULE_NAME ?=

SRC_DIR   ?= src
BUILD_DIR ?= build

OBJ_DIR = $(BUILD_DIR)/obj/$(MODULE_NAME)
BIN_DIR = $(BUILD_DIR)/bin/$(MODULE_NAME)

ifndef verbose
	verbose := 0
endif

ifeq ($(verbose), 0)
	SILENT := @
endif

SILENT ?=

NASM := nasm

NASM_FLAGS :=
