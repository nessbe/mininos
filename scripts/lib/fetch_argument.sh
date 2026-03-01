#!/usr/bin/env bash

# scripts/lib/fetch_argument.sh
#
# Copyright (c) 2026-Present Nessbe
#
# This file is licensed under the terms specified in the
# LICENSE file located at the root of this repository.

source scripts/lib/error.sh

fetch_argument() {
	local index="$1"
	shift

	local args=("$@")
	local count="${#args[@]}"

	if [[ ! "$index" =~ ^[0-9]+$ ]]; then
		error "Invalid index '$index'"
		return 1
	fi

	if (( index >= count )); then
		error "Index '$index' out of range"
		return 1
	fi

	echo "${args[index]}"
}
