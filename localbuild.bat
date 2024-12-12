@echo off

:: This batch file is used for troubleshooting stuff locally, without involving github or nuget.

:: See Stack Overflow: "Detect if bat file is running via double click or from cmd window"
:: https://stackoverflow.com/a/61511609/773113
if /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" echo Invoke this script from a command window that stays open, otherwise the version number will not increment.

if "%SUFFIX%"=="" (
	set SUFFIX=900
) else (
	set /A SUFFIX=SUFFIX+1
)
set RELEASE_VERSION=1.1.%SUFFIX%
echo RELEASE_VERSION=%RELEASE_VERSION%
call vsclean
	
rd /S/Q %USERPROFILE%\Personal\Dev\Dotnet\Main\LocalNugetSource
mkdir %USERPROFILE%\Personal\Dev\Dotnet\Main\LocalNugetSource
	
rd /S/Q %USERPROFILE%\.nuget\packages\mikenakis.analysisrules
	
dotnet pack
dotnet nuget push bin/Release/MikeNakis.AnalysisRules.%RELEASE_VERSION%.nupkg --source %USERPROFILE%\Personal\Dev\Dotnet\Main\LocalNugetSource
