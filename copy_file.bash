#!/bin/bash

source $(dirname "$0")/definitions.bash > /dev/null

function get_file()
{
	declare -r source=$1
	declare -r target=$2

	if [[ ! -f $source ]]; then
		error "Source file does not exist: '%s'" "$source"
		exit 0
	fi

	if [[ ! -f $target ]]; then

		info "Target file does not exist: '%s'" "$target"

	else

		if cmp --silent -- "$source" "$target"; then
			info "Source file is identical to target; skipping: '%s'" "$target"
			return 0
		fi

		while :
		do
			warn "Source file '%s' is different from target file '%s'" "$source" "$target"
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

	info "Copy '%s' to '%s'" "$source" "$target"

	[[ $dry_run == true ]] && return

	cp "$source" "$target"
	return 0
}

function run()
{
	declare dry_run=false
	declare target=

	while [ $# -gt 0 ]; do
		case "$1" in
			--source=*)
				source="${1#*=}"
				;;
			--target=*)
				target="${1#*=}"
				;;
			--dry-run)
				dry_run=true
				;;
			*)
				error "Invalid argument: '%s'" "$1"
				exit 1
		esac
		shift
	done

	if [[ -z $source ]]; then
		error "Missing argument: '%s'" "--source-filename"
		exit 1
	fi

	if [[ -z $target ]]; then
		target=$source
	fi

	get_file "$(dirname "$self")/$source" "$target"
}

run $@
