# scripts/build.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

#!/usr/bin/sh

BUILD_DIR=build

if ! command -v cmake >/dev/null 2>&1
then
	echo "'cmake' binary could not be found"
	exit 1
fi

cmake -S . -B "$BUILD_DIR"
cmake --build "$BUILD_DIR"
