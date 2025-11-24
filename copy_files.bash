#!/bin/bash

set -o errexit -o nounset -o pipefail
shopt -s expand_aliases
# set -x

function log()
{
	local self=$1; shift
	local line=$1; shift
	local level=$1; shift
	local message="$@"

	printf "%s(%s): %s: %s\n" "${self}" ${line} "${level}" "${message}"
}

declare self=$(realpath "$0")

alias info='log ${self} ${LINENO} INFO'
alias warn='log ${self} ${LINENO} WARN'
alias error='log ${self} ${LINENO} ERROR'

declare source_path=$(dirname "${self}")

declare target_path=$(realpath ${1-})
if [ ! -d "${target_path}" ]; then
	error "Directory does not exist: '${target_path}'"
	exit 0
fi

function get_file()
{
	local source_filename=$1
	local target_filename=${2-}

	if [[ -z "${target_filename}" ]]; then
		target_filename=${source_filename}
	fi

	local source_pathname="${source_path}/${source_filename}"
	if [ ! -f "${source_pathname}" ]; then
		error "Source file does not exist: '${source_pathname}'"
		exit 0
	fi

	local target_pathname="${target_path}/${target_filename}"
	if [ ! -f "${target_pathname}" ]; then

		info "Target file does not exist: '${target_filename}'"

	else

		if cmp --silent -- "${source_pathname}" "${target_pathname}"; then
			info "Target file is identical to source; skipping: '${target_filename}'"
			return 0
		fi

		while :
		do
			warn Target file is different from source: ${target_pathname} and ${source_pathname}
			read -p "(S)kip, (O)verwrite, or (A)bort? " -n1 character
			printf "\n"
			case "${character}" in
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

	info Copying: ${target_filename}
	cp --no-target-directory ${source_pathname} ${target_pathname}
	return 0
}

while IFS=$'\n' read line; do
    # info "line: '${line}'"
	IFS=' ' read source target <<< "${line}"
    # info "source: '${source}' target: '${target}'"
	get_file "${source}" "${target}"
done
