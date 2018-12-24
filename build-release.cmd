@echo off
@setlocal
set ERROR_CODE=0
set DIR=%CD%
if "%FrameworkDir%" == "" goto EnvError
where /q git
if %ERRORLEVEL%==1 goto GitError
if "%1"=="" goto ArgError
if "%2"=="" goto ArgError
if "%3"=="" goto ArgError
if "%4"=="" goto ArgError
set MAJOR=%1
set MINOR=%2
set PATCH=%3
set BUILD=%4
if not "%5"=="" (
   set SPECIAL=%5
)
if not exist "DevAudit.sln" goto SlnError
set TAG=v%MAJOR%.x
set BUILD_TAG=%MAJOR%.%MINOR%.%PATCH%.%BUILD%
if not "%5"=="" (
   set RELEASE_TAG=%BUILD_TAG%-%SPECIAL%
) else (
    set RELEASE_TAG=%BUILD_TAG%
)
set BUILD_DIR=DevAudit.%TAG%.Build_%BUILD%
set RELEASE_DIR=%RELEASE_TAG%\DevAudit
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%"
)
if exist "%RELEASE_TAG%" (
    rmdir /s /q "%RELEASE_TAG%"
)
if exist "%RELEASE_DIR%" (
    rmdir /s /q "%RELEASE_DIR%"
)
git clone --branch "%TAG%" https://github.com/OSSIndex/DevAudit %BUILD_DIR%
if not %ERRORLEVEL% == 0 goto CheckoutError
mkdir %RELEASE_TAG%
mkdir %RELEASE_TAG%\DevAudit
cd %BUILD_DIR%
call build.cmd "VersionAssembly=%MAJOR%.%MINOR%.%PATCH%.%BUILD%"
cd %DIR%
if not %ERRORLEVEL%==0 goto BuildError
if not exist "%BUILD_DIR%\Analyzers" goto AnalyzersDirError
if not exist "%BUILD_DIR%\Rules" goto RulesDirError
if not exist "%BUILD_DIR%\Examples" goto ExamplesDirError
xcopy /E /Y %BUILD_DIR%\DevAudit.AuditLibrary\bin\Debug\Gendarme.Rules.*  %BUILD_DIR%\DevAudit.CommandLine\bin\Debug\
xcopy /E /Y %BUILD_DIR%\DevAudit.CommandLine\bin\Debug\* %RELEASE_DIR%
mkdir %RELEASE_DIR%\Examples & xcopy /E /Y %BUILD_DIR%\Examples %RELEASE_DIR%\Examples
copy .\README.md %RELEASE_DIR%
copy .\LICENSE %RELEASE_DIR%
cd %RELEASE_TAG%
%DIR%\.7zip\7za a -tzip -r %DIR%\DevAudit-%RELEASE_TAG%.zip DevAudit
cd %DIR%
echo Release %RELEASE_TAG% created at %RELEASE_DIR% and at archive %DIR%\DevAudit-%RELEASE_TAG%.zip.
goto End

:EnvError
echo You must run this batch file from a Visual Studio command prompt or run vsvars32.bat before.
set ERROR_CODE=1
goto Error

:GitError
echo Git must be in the current PATH.
set ERROR_CODE=2
goto Error

:CheckoutError
echo There was an error during checkout of branch %TAG%.
set ERROR_CODE=%ERRORLEVEL%
goto Error

:ArgError
echo Command syntax is build-release.cmd major minor patch build [special].
set ERROR_CODE=4
goto Error

:SlnError
echo DevAudit.sln file could not be found.
set ERROR_CODE=5
goto Error

:BuildError
echo An error occurred during build.
set ERROR_CODE=6
goto Error

:AnalyzersDirError
echo The %BUILD_DIR%\Analyzers directory could not be found. An error may have occurred during build.
set ERROR_CODE=7
goto Error

:RulesDirError
echo The %BUILD_DIR%\Rules directory could not be found. An error may have occurred during build.
goto Error

:ExamplesDirError
echo The %BUILD_DIR%\Examples directory could not be found. An error may have occurred during build.
set ERROR_CODE=7
goto Error

:Error
if exist "%RELEASE_DIR%" (
    rmdir /s /q "%RELEASE_DIR%"
)

:End
cd %DIR%
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%"
)
@endlocal
exit /b %ERROR_CODE%