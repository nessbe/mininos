#!/usr/bin/env bash

# scripts/build.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

source scripts/lib/assert_command.sh
source scripts/lib/fetch_argument.sh

NINJA="ninja"
ARCHITECTURE=$(fetch_argument 0 $@ 2>/dev/null) || {
	echo "Invalid usage of setup.sh, expected an architecture as the first argument"
	exit 1
}

LOG_FILE="logs/ninja-build.log"
LOG_DIR=$(dirname "$LOG_FILE")

BUILD_DIR="build"

assert_command "$NINJA" || {
	echo "Ninja binary '$NINJA' not found"
	exit 1
}
sh scripts/setup.sh "$ARCHITECTURE"

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
