#!/bin/bash

set -o errexit -o nounset -o pipefail
shopt -s expand_aliases
# set -x

bash ../Blaster/get_common_files.bash
bash ../Cato/get_common_files.bash
bash ../digital-garden-programming/get_common_files.bash
bash ../MikeNakis.Clio/get_common_files.bash
bash ../MikeNakis.Console/get_common_files.bash
bash ../MikeNakis.CSharpTypeNames/get_common_files.bash
bash ../MikeNakis.Kit/get_common_files.bash
bash ../MikeNakis.SvgConvert/get_common_files.bash
bash ../MikeNakis.Testing/get_common_files.bash
bash ../MikeNakis.VsTail.Proxy/get_common_files.bash
bash ../Solution/get_common_files.bash
bash ../TicTacToe/get_common_files.bash
