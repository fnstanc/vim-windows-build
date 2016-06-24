@echo off

:: Windows SDK Include directory. No quotation marks.
set SDK_INCLUDE_DIR=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include

:: Visual Studio directory. Quotation marks.
set VS_DIR="D:\Program Files (x86)\Microsoft Visual Studio 12.0"

:: Vim source
set VIM_SRC="vim"

:: Release path
set VIM_RELEASE="vim74"

:: Target architecture, AMD64 (64-bit) or I386 (32-bit)
set CPU=I386

:: Toolchain, x86_amd64 (cross-compile 64-bit) or x86 (32-bit) or amd64 (64-bit)
set TOOLCHAIN=x86

:: TINY, SMALL, NORMAL, BIG or HUGE. NORMAL or above recommended
set FEATURES=HUGE

SET OPTIMIZE=MAXSPEED

:: IDE integrations we don't need
set NETBEANS=no
set CSCOPE=no

:: UTF-8 encoding
set MBYTE=yes

:: Enable Python scripting
set DYNAMIC_PYTHON=yes
set PYTHON=C:\Python27
SET PYTHON_VER=%LIBPYTHON2%

REM SET PYTHON3=C:\Python35
REM SET DYNAMIC_PYTHON3=yes
REM SET PYTHON3_VER=%LIBPYTHON3%

REM :: Enable Lua scripting
REM SET LUA=C:\lua
REM SET DYNAMIC_LUA=yes
REM SET LUA_VER=%LIBLUASHRT%

REM :: TCL
REM SET TCL=C:\Dev\Utils\tcl
REM SET TCL_VER=%LIBTCLSHRT%
REM SET TCL_VER_LONG=%LIBTCLLONG%
REM SET DYNAMIC_TCL=yes

REM :: Perl
REM SET PERL=C:\Dev\perl
REM SET DYNAMIC_PERL=yes
REM SET PERL_VER=%LIBPERLVER%

echo "Configuring Visual Studio..."
call %VS_DIR%\VC\vcvarsall.bat %TOOLCHAIN%

echo "Build gvim..."
pushd %VIM_SRC%\src

set GUI=yes
call %VS_DIR%\VC\bin\nmake -f Make_mvc.mak

set GUI=no
call %VS_DIR%\VC\bin\nmake -f Make_mvc.mak

popd

xcopy %VIM_SRC%\runtime %VIM_RELEASE% /D /S /H /I /Y
xcopy %VIM_SRC%\src\xxd\xxd.exe %VIM_RELEASE% /D /Y
xcopy %VIM_SRC%\src\GvimExt\gvimext.dll %VIM_RELEASE% /D /Y
xcopy %VIM_SRC%\src\*.exe %VIM_RELEASE% /D /Y
xcopy %VIM_SRC%\src\*.pdb %VIM_RELEASE% /D /Y

pause
