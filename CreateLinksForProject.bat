@echo off

setlocal

set targetDirectory=%~1

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

call :make .editorconfig
call :make .gitignore
call :make .gitattributes
call :make AllCode.globalconfig
call :make AllProjects.proj.xml
call :make BannedApiAnalyzers.proj.xml
call :make BannedSymbols.txt
call :make ProductionCode.globalconfig
call :make TestCode.globalconfig
:: call :make build.bash
:: call :make publish.bash
exit /b 1

:make
	if not exist "%1" (
		echo Source file does not exist: '%1'
		exit /b 1
	)
	if exist "%targetDirectory%\%1" goto :exists
	goto :create

:exists
	fc "%targetDirectory%\%1" "%1" > nul
	if errorlevel 1 goto :different
	::file exists and it is identical
	echo Target file '%targetDirectory%\%1' exists and is identical to source file '%1'
	goto :eof

:different
	echo ==== WARNING: Target file '%targetDirectory%\%1' exists and is different from source file '%1'
	choice /c os /m "Overwrite, or Skip?"
	if %errorlevel% equ 1 (
		del "%targetDirectory%\%1"
		goto :create
	) else if %errorlevel% equ 2 (
		echo Skipping %1.
	) else (
		echo ERROR %errorlevel%
		exit /b 1
	)
	goto :eof

:create
	echo Creating link '%targetDirectory%\%1' --^> '%1'
	mklink /h %targetDirectory%\%1 %1 > nul
	:: echo Copying '%targetDirectory%\%1' --^> '%1'
	:: copy /Y %1 %targetDirectory%\%1 > nul
	goto :eof
