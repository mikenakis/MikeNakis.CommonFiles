#!/bin/bash

set -o errexit -o nounset -o pipefail
shopt -s expand_aliases

declare -r my_directory=$(dirname $(realpath --relative-to="$PWD" $0))

function copy_common_files_for_project()
{
	declare -r project_directory=$1
	echo === $project_directory =========================================================
	bash $my_directory/$project_directory/get_common_files.bash
	echo 
}

copy_common_files_for_project ../Blaster
copy_common_files_for_project ../Cato
copy_common_files_for_project ../digital-garden-programming
copy_common_files_for_project ../MikeNakis.Clio
copy_common_files_for_project ../MikeNakis.Console
copy_common_files_for_project ../MikeNakis.CSharpTypeNames
copy_common_files_for_project ../MikeNakis.Kit
copy_common_files_for_project ../MikeNakis.SvgConvert
copy_common_files_for_project ../MikeNakis.Testing
copy_common_files_for_project ../MikeNakis.VsTail.Proxy
copy_common_files_for_project ../Solution
copy_common_files_for_project ../TicTacToe
