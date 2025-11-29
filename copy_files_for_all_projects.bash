#!/bin/bash

set -o errexit -o nounset -o pipefail
shopt -s expand_aliases
# set -x

function project()
{
	declare -r project_directory=$1
	echo === $project_directory ======================================================================================
	(cd "$project_directory" && bash get_common_files.bash)
}

project ../Blaster
project ../Cato
project ../digital-garden-programming
project ../MikeNakis.Clio
project ../MikeNakis.Console
project ../MikeNakis.CSharpTypeNames
project ../MikeNakis.Kit
project ../MikeNakis.SvgConvert
project ../MikeNakis.Testing
project ../MikeNakis.VsTail.Proxy
project ../Solution
project ../TicTacToe
