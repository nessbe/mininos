#!/usr/bin/env bash

# scripts/run.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

source scripts/lib/assert_command.sh
source scripts/lib/fetch_argument.sh

MESON="meson"

ARCHITECTURE=$(fetch_argument 0 $@ 2>/dev/null) || {
	echo "Invalid usage of run.sh, expected an architecture as the first argument"
	exit 1
}

LOG_FILE="logs/qemu-run.log"
LOG_DIR=$(dirname "$LOG_FILE")

BUILD_DIR="build"
RUN_TARGET="run_qemu"

assert_command "$MESON" || {
	echo "Meson binary '$MESON' not found"
	exit 1
}
sh scripts/build.sh "$ARCHITECTURE"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

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
