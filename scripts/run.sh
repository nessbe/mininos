# scripts/run.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

#!/usr/bin/sh

BUILD_DIR=build
RUN_TARGET=run

scripts/default_generator.sh
cmake --build "$BUILD_DIR" --target $RUN_TARGET
