@echo off

setlocal

set sourceDirectory=%~1
set targetDirectory=%~2

if not exist "%sourceDirectory%\" (
	echo directory not found: '%sourceDirectory%'
	goto :eof
)

if not exist "%targetDirectory%\" (
	echo directory not found: '%targetDirectory%'
	goto :eof
)

if not exist "%targetDirectory%\.git\" (
	echo not a git repository directory: '%targetDirectory%'
	goto :eof
)

if not exist "%targetDirectory%\*.sln?" (
	echo not a solution directory: '%targetDirectory%'
	exit /b 1
)

call :mk .editorconfig
call :mk .gitignore
call :mk .gitattributes
call :mk AllCode.globalconfig
call :mk AllProjects.proj.xml
call :mk BannedApiAnalyzers.proj.xml
call :mk BannedSymbols.txt
call :mk ProductionCode.globalconfig
call :mk TestCode.globalconfig
call :mk build.bash
call :mk publish.bash
exit /b 1

:mk
	if not exist "%sourceDirectory%\%1" (
		echo file does not exist: '%sourceDirectory%\%1'
		goto :eof
	)
	if exist "%targetDirectory%\%1" goto :exists
	goto :recreate

:exists
	fc "%targetDirectory%\%1" "%sourceDirectory%\%1" > nul
	if errorlevel 1 goto :different
	::file exists and it is identical
	:: echo '%targetDirectory%\%1' exists and is identical to '%sourceDirectory%\%1'
	goto :eof
	::del "%targetDirectory%\%1"
	::goto :recreate

:different
	echo ==== WARNING: '%targetDirectory%\%1' exists and is different from '%sourceDirectory%\%1'
	choice /c os /m "Overwrite, or Skip?"
	if %errorlevel% equ 1 (
		del "%targetDirectory%\%1"
		goto :recreate
	) else if %errorlevel% equ 2 (
		echo skipping %1.
	) else (
		echo ERROR %errorlevel%
	)
	goto :eof

:recreate
	echo Creating link '%targetDirectory%\%1' --^> '%sourceDirectory%\%1'
	mklink /h %targetDirectory%\%1 %sourceDirectory%\%1 > nul
	goto :eof
