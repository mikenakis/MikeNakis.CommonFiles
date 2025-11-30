#!/bin/bash

source $(dirname "$0")/files/definitions.bash > /dev/null

function get_file()
{
	declare -r source=$1
	declare -r target=$2

	if [[ ! -f $source ]]; then
		error "Source file does not exist: '$source'"
		exit 0
	fi

	if [[ ! -f $target ]]; then

		info "Target file does not exist: '$target'"

	else

		if cmp --silent -- "$source" "$target"; then
			info "Source file is identical to target; skipping: '$target'"
			return 0
		fi

		while :
		do
			warn "Source file '$source' is different from target file '$target'"
			read -p "(S)kip, (O)verwrite, or (A)bort? " -n1 character
			printf "\n"
			case "$character" in
				S|s)
					info Skipping.
					return 0
					;;
				O|o)
					break
					;;
				A|a)
					info Aborting.
					exit 1
					;;
				*)
					error "Invalid choice: '${character}'"
					;;
			esac
		done

	fi

	info "Copy '$source' to '$target'"

	[[ $dry_run == true ]] && return

	cp "$source" "$target"
	return 0
}

function run()
{
	declare dry_run=false
	declare file_list_filepath=

	while [ $# -gt 0 ]; do
		case "$1" in
			--file-list=*)
				file_list_filepath="${1#*=}"
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

	if [[ -z $file_list_filepath ]]; then
		error "Missing argument: '--file-list'"
		exit 1
	fi

	declare -r common_files_directory=$(dirname "$0")

	while IFS=$'\r\n' read -u3 line; do

		if [[ $line == "" || $line == \#* ]]; then
			continue
		fi

		IFS=' ' read -r source target <<< "$line"

		if [[ -z $target ]]; then
			target=$source
		fi

		get_file "$common_files_directory/files/$source" "$target"

	done 3< "$file_list_filepath"
}

run $@
