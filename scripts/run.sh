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

ARCHITECTURE=$(fetch_argument 0 $@ 2>/dev/null) || {
	echo "Invalid usage of run.sh, expected an architecture as the first argument"
	exit 1
}
TARGET="run_qemu"

echo "Running project..."

sh scripts/execute.sh "$ARCHITECTURE" "$TARGET"

echo "Successfully ran project"
