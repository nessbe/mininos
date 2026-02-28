#!/usr/bin/env bash

# scripts/build.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

BUILD_DIR="build"

if [ ! -d "$BUILD_DIR" ]; then
	echo "Project setup was not detected. Attempting setup..."

	if [ "$#" -lt 1 ]; then
		echo "Building without prior setup requires specifying an architecture as the first argument"
		exit 1
	fi

	ARCHITECTURE="$1"
	sh scripts/setup.sh "$ARCHITECTURE"
fi

NINJA="ninja"

if ! command -v "$NINJA" >/dev/null 2>&1; then
	echo "Ninja binary '$NINJA' not found"
	exit 1
fi

LOG_FILE="logs/ninja-build.log"
LOG_DIR=$(dirname "$LOG_FILE")

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

if ! "$NINJA" -C "$BUILD_DIR" >"$LOG_FILE" 2>&1; then
	echo "Failed to build project"

	while IFS= read -r line; do
		echo "	${line//\\/\/}"
	done < <(grep -i "error" "$LOG_FILE" || true)

	exit 1
fi

echo "Project build was successful"
