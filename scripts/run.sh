#!/usr/bin/env bash

# scripts/run.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

if [ "$#" -lt 1 ]; then
	echo "Invalid usage of run.sh, expected an architecture as the first argument"
	exit 1
fi

ARCHITECTURE="$1"
sh scripts/build.sh "$ARCHITECTURE"

LOG_FILE="logs/qemu-run.log"
LOG_DIR=$(dirname "$LOG_FILE")

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

MESON="meson"

if ! command -v "$MESON" >/dev/null 2>&1; then
	echo "Meson binary '$MESON' not found"
	exit 1
fi

echo "Running project..."

BUILD_DIR="build"
RUN_TARGET="run_qemu"

if ! "$MESON" compile "$RUN_TARGET" -C "$BUILD_DIR" >"$LOG_FILE" 2>&1; then
	echo "Failed to run project"

	ERROR_LINES=$(grep -i "error" "$LOG_FILE" | tr '\\' '/' || true)

	if [ -n "$ERROR_LINES" ]; then
		printf "\t%s\n" "$ERROR_LINES"
	fi

	exit 1
fi

echo "Successfully ran project"
