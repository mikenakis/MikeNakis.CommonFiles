#!/bin/bash

source $(dirname "$0")/files/definitions.bash > /dev/null

source $(dirname "$0")/copy_files_common.bash > /dev/null

declare -r my_directory=$(dirname $(realpath --relative-to="$PWD" "$0"))
	
function run()
{
	declare dry_run=false
	declare target_directory=

	while [ $# -gt 0 ]; do
		case "$1" in
			--target-directory=*)
				target_directory="${1#*=}"
				;;
			--dry-run)
				dry_run=true
				;;
			*)
				error "Invalid argument: '$1'"
				exit 1
		esac
		shift
	done

	if [[ -z $target_directory ]]; then
		error "Missing argument: '--target_directory'"
		exit 1
	fi

	copy_files $my_directory $target_directory
}

run $@
