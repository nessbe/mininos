# File:       Makefile
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

include make/config.mk

SUBDIRS := src

.PHONY: all clean

all:
	@for d in $(SUBDIRS); do $(MAKE) --no-print-directory -C $$d; done

clean:
	@echo "Cleaning..."
	$(SILENT) rm -rf "$(BUILD_DIR)"
