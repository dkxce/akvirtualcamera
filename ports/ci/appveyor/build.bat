REM akvirtualcamera, virtual camera for Mac and Windows.
REM Copyright (C) 2021  Gonzalo Exequiel Pedone
REM
REM akvirtualcamera is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM akvirtualcamera is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You should have received a copy of the GNU General Public License
REM along with akvirtualcamera. If not, see <http://www.gnu.org/licenses/>.
REM
REM Web-Site: http://webcamoid.github.io/

set INSTALL_PREFIX=%APPVEYOR_BUILD_FOLDER%\package-data

echo.
echo Building x64 virtual camera driver
echo.

mkdir build-x64
setlocal

if "%CMAKE_GENERATOR%" == "MSYS Makefiles" set PATH=C:\msys64\mingw64\bin;C:\msys64\usr\bin;%PATH%
if "%CMAKE_GENERATOR%" == "MSYS Makefiles" (
    cmake ^
        -LA ^
        -S . ^
        -B build-x64 ^
        -G "%CMAKE_GENERATOR%" ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
    cmake --build build-x64 --parallel "%NJOBS%"
    cmake --build build-x64 --target install
)

endlocal

if "%CMAKE_GENERATOR:~0,13%" == "Visual Studio" (
    cmake ^
        -LA ^
        -S . ^
        -B build-x64 ^
        -G "%CMAKE_GENERATOR%" ^
        -A x64 ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
    cmake --build build-x64 --config Release  --parallel "%NJOBS%"
    cmake --build build-x64 --config Release --target install
)

echo.
echo Building x86 virtual camera driver
echo.

mkdir build-x86
setlocal

if "%CMAKE_GENERATOR%" == "MSYS Makefiles" set PATH=C:\msys64\mingw32\bin;C:\msys64\usr\bin;%PATH%
if "%CMAKE_GENERATOR%" == "MSYS Makefiles" (
    cmake ^
        -LA ^
        -S . ^
        -B build-x86 ^
        -G "%CMAKE_GENERATOR%" ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
    cmake --build build-x86 --parallel "%NJOBS%"
    cmake --build build-x86 --target install
)

endlocal

if "%CMAKE_GENERATOR:~0,13%" == "Visual Studio" (
    cmake ^
        -LA ^
        -S . ^
        -B build-x86 ^
        -G "%CMAKE_GENERATOR%" ^
        -A Win32 ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"
    cmake --build build-x86 --config Release --parallel "%NJOBS%"
    cmake --build build-x86 --config Release --target install
)
