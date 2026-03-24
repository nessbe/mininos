#!/usr/bin/env bash

# scripts/tools/pad_kernel.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

set -euo pipefail

INPUT="$1"
OUTPUT="$2"
MIN_SIZE="$3"

dd if=/dev/zero of="$OUTPUT" bs=1 count="$MIN_SIZE"
dd if="$INPUT" of="$OUTPUT" conv=notrunc
