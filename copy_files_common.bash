#!/bin/bash

echo "This script is meant to be sourced from other scripts; it is not meant to be directly executed."

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
}

function copy_files()
{
	declare -r common_files_directory=$1
	declare -r target_directory=$2

	while IFS=$'\r\n' read -u3 line; do

		if [[ $line == "" || $line == \#* ]]; then
			continue
		fi

		IFS=' ' read -r source target <<< "$line"

		if [[ -z $target ]]; then
			target=$source
		fi

		get_file "$common_files_directory/files/$source" "$target_directory/$target"

	done 3< "$target_directory/common_files.txt"
}
