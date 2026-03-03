#!/usr/bin/env bash

# scripts/execute.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

source scripts/lib/assert_command.sh
source scripts/lib/error.sh
source scripts/lib/fetch_argument.sh

MESON="meson"

ARCHITECTURE=$(fetch_argument 0 $@ 2>/dev/null) || {
	error "Invalid usage of execute.sh, expected an architecture as the first argument"
	exit 1
}

TARGET=$(fetch_argument 1 $@ 2>/dev/null) || {
	error "Invalid usage of execute.sh, expected a target name as the second argument"
	exit 1
}

BUILD_DIR="build"

assert_command "$MESON" || {
	error "Meson binary '$MESON' not found"
	exit 1
}

sh scripts/build.sh "$ARCHITECTURE"

OUTPUT="$("$MESON" compile "$TARGET" -C "$BUILD_DIR" 2>&1)" || {
	error "Failed to execute target '$TARGET'"

	ERROR_LINES=$(printf "%s\n" "$OUTPUT" | grep -i "error" | tr '\\' '/' || true)

	if [ -n "$ERROR_LINES" ]; then
		printf "\t%s\n" "$ERROR_LINES"
	fi

	exit 1
}

echo "Executed target '$TARGET' successfully"
