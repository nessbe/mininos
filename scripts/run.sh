#!/usr/bin/env bash

# scripts/run.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

MESON="meson"

if ! command -v "$MESON" >/dev/null 2>&1; then
	echo "Meson binary '$MESON' not found"
	exit 1
fi

if [ "$#" -lt 1 ]; then
	echo "Invalid usage of run.sh, expected an architecture as the first argument"
	exit 1
fi

BUILD_DIR="build"
BUILD_SRC_DIR="$BUILD_DIR/src"

if [ ! -d "$BUILD_SRC_DIR" ]; then
	echo "Project build was not detected. Attempting build..."

	if [ "$#" -lt 1 ]; then
		echo "Building without prior build requires specifying an architecture as the first argument"
		exit 1
	fi

	ARCHITECTURE="$1"
	sh scripts/build.sh "$ARCHITECTURE"
fi

LOG_FILE="logs/qemu-run.log"
LOG_DIR=$(dirname "$LOG_FILE")

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

RUN_TARGET="run_qemu"
echo "Running project..."

if ! "$MESON" compile "$RUN_TARGET" -C "$BUILD_DIR" >"$LOG_FILE" 2>&1; then
	echo "Failed to run project"

	ERROR_LINES=$(grep -i "error" "$LOG_FILE" | tr '\\' '/' || true)

	if [ -n "$ERROR_LINES" ]; then
		printf "\t%s\n" "$ERROR_LINES"
	fi

	exit 1
fi

echo "Successfully ran project"
