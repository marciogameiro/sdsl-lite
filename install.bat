@echo off
cls
set CUR_DIR=%cd%
echo CUR_DIR=%CUR_DIR%

set SDSL_INSTALL_PREFIX=%USERPROFILE%
if not "%1"=="" (
    pushd .
    cd %~dp0
    set SDSL_INSTALL_PREFIX=%~f1
    popd    
)
echo Library will be installed in %SDSL_INSTALL_PREFIX%

rem Change to the directory in which this script is located in
cd %~dp0

rem TODO git hook

cd build
if errorlevel 1 (
    exit /b %errorlevel% 
)

rem TODO clean-up build directory

cmake -DCMAKE_INSTALL_PREFIX="${SDSL_INSTALL_PREFIX}" -G"Visual Studio 17 2022" ..
if errorlevel 1 (
    echo ERROR: CMake build failed
    exit /b %errorlevel%
)

msbuild -t:sdsl -p:configuration=Release -p:RuntimeLibrary=MultiThreadedDLL sdsl.sln
