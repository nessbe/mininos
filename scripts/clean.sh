#!/usr/bin/env bash

# scripts/clean.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

BUILD_DIR="build"

if [ -d "$BUILD_DIR" ]; then
	rm -rf "$BUILD_DIR"
	echo "Removed build directory '$BUILD_DIR'"
fi

echo "Project build was successful"
