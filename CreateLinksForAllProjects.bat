@echo off
if not exist "MikeNakis.CommonFiles.csproj" (
	echo this script must be run in the MikeNakis.CommonFiles project directory.
	goto :eof
)

call :x ..\digital-garden-programming
call :x ..\MikeNakis.Clio
call :x ..\MikeNakis.Console
call :x ..\MikeNakis.CSharpTypeNames
call :x ..\MikeNakis.Kit
call :x ..\MikeNakis.SvgConvert
call :x ..\MikeNakis.VsTail.Proxy
call :x ..\Solution
call :x ..\Cato
call :x ..\Blaster
call :x ..\MikeNakis.Testing
goto :eof

:x
  echo ==== %1
  call CreateLinksforProject %1
  goto :eof
