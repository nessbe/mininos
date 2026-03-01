#!/usr/bin/env bash

# scripts/lib/assert_command.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

source scripts/lib/error.sh

assert_command() {
	local command="$1"

	if [[ -z "$command" ]]; then
		error "Command name cannot be empty"
		return 1
	fi

	if ! command -v "$command" >/dev/null 2>&1; then
		error "Command '$command' does not exist"
		return 1
	fi
}
