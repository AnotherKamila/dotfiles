#!/bin/sh
# verifies whether the expected programs exist

# $1: identification
# $2: command
check_program_exists() {
	which $2 >/dev/null || echo "$1 missing: $2"
}

check_program_exists SHELL   {{SHELL}}
check_program_exists EDITOR  {{EDITOR}}
check_program_exists BROWSER {{BROWSER}}
check_program_exists PAGER   {{PAGER}}
