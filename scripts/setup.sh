#!/usr/bin/env bash

# scripts/setup.sh
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
	echo "Invalid usage of setup.sh, expected an architecture as the first argument"
	exit 1
fi

LOG_FILE="logs/meson-setup.log"
LOG_DIR=$(dirname "$LOG_FILE")

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

ARCHITECTURE="$1"
TOOLCHAIN_DIR="meson/toolchains"
CROSS_FILE="$TOOLCHAIN_DIR/$ARCHITECTURE-toolchain.conf"

if [ ! -f "$CROSS_FILE" ]; then
	echo "Cross compilation file not found: $CROSS_FILE"
	exit 1
fi

BUILD_DIR="build"

if ! "$MESON" setup --reconfigure "$BUILD_DIR" --cross-file "$CROSS_FILE" >"$LOG_FILE" 2>&1; then
	echo "Failed to setup project"

	ERROR_LINES=$(grep -i "error" "$LOG_FILE" | tr '\\' '/' || true)

	if [ -n "$ERROR_LINES" ]; then
		printf "\t%s\n" "$ERROR_LINES"
	fi

	exit 1
fi

echo "Project setup was successful"
