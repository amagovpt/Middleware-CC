:: If DEBUG=1 open project in VS,
:: if      =0 just build it all
@if "%DEBUG%" == "" (
	echo Variable DEBUG is NOT defined. Set DEBUG mode on.
	@set DEBUG=1
) 

:: Output Build log to console
@if "%OUTPUTLOG%" == "" (
	echo Output Build log to console is NOT defined. Set OUTPUTLOG on.
	@set OUTPUTLOG=1
) 

:: MW version
@set MW_VERSION=3

:: If SKIP_X64_DEPS_CHECK=1 if set will skip cheking %<DEPS>_X64% to see if they are in place.
:: Useful if for just compiling and creating the x86 targets
@set SKIP_X64_DEPS_CHECK=0

echo DEBUG=%DEBUG%
echo OUTPUTLOG=%OUTPUTLOG%
echo MW_VERSION=%MW_VERSION%
echo SKIP_X64_DEPS_CHECK=%SKIP_X64_DEPS_CHECK%

:: Crete versions file for the Windows binaries
:: This versions are the real version of the middleware
for /f "delims== tokens=1,2" %%G in (%~dp0..\_src\eidmw\release_data) do set %%G=%%H

set OUTPUT_FILE=%~dp0..\_src\eidmw\release_data.wxs
echo ^<Include^> > "%OUTPUT_FILE%"
echo ^<?define RevisionNumber=%REVISION_NUM%?^> >> "%OUTPUT_FILE%"
echo ^<?define PTeidProductVersion=%PTEID_PRODUCT_VERSION%?^> >> "%OUTPUT_FILE%"
echo ^</Include^> >> "%OUTPUT_FILE%"

set OUTPUT_FILE=%~dp0..\_src\eidmw\release_data.h
echo #ifndef __RELEASE_DATA_H__ > "%OUTPUT_FILE%"
echo #define __RELEASE_DATA_H__ >> "%OUTPUT_FILE%"
echo #define PTEID_COPYRIGHT          "%COPYRIGHT%" >> "%OUTPUT_FILE%"
echo #define PTEID_PRODUCT_VERSION    "%PTEID_PRODUCT_VERSION%" >> "%OUTPUT_FILE%"
echo #define BASE_VERSION_STRING      "%PTEID_MAJOR%, %PTEID_MINOR%, %PTEID_PATCH%, " >> "%OUTPUT_FILE%"
echo #define BASE_VERSION1            %PTEID_MAJOR% >> "%OUTPUT_FILE%"
echo #define BASE_VERSION2            %PTEID_MINOR% >> "%OUTPUT_FILE%"
echo #define BASE_VERSION3            %PTEID_PATCH% >> "%OUTPUT_FILE%"
echo #define REVISION_NUM             %REVISION_NUM% >> "%OUTPUT_FILE%"
echo #define REVISION_NUM_STRING      "%REVISION_NUM%" >> "%OUTPUT_FILE%"
echo #endif //__RELEASE_DATA_H__ >>  "%OUTPUT_FILE%"


@call "%~dp0make_win_vc9.bat"