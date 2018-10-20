@echo off

:: 
:: Windows setup script for ytd.py
::
:: author: alan jean
::         github.com/occupytheweb 
::
:: usage: 
::         .\install.bat       - launch the installer in interactive mode
::         .\install.bat dev   - installs ytd.py, skipping python installation
::         .\install.bat help  - displays usage information
::

REM print banner
for /f "useback delims=" %%_ in (%0) do (
  if "%%_"=="___EOF___" set $=
  if defined $ echo(%%_
  if "%%_"=="___BANNER___" set $=1
)
goto :start

___BANNER___
        _      _               
       | |    | |              
  _   _| |_ __| |  _ __  _   _ 
 | | | | __/ _` | | '_ \| | | |
 | |_| | || (_| |_| |_) | |_| |
  \__, |\__\__,_(_) .__/ \__, |
   __/ |          | |     __/ |
  |___/   setup   |_|    |___/ 

___EOF___
REM end banner
:start


:parse_args
if "%~1"==""     goto :interactive
if "%~1"=="dev"  goto :install_runtime_dependencies
if "%~1"=="help" goto :help


:help
echo.
echo Usage:
echo   .\install.bat       - launch the installer in interactive mode
echo   .\install.bat dev   - installs ytd.py, skipping python installation
echo   .\install.bat help  - displays this help message
echo.
exit /b


:interactive
echo.
call :print_title Python3 setup
choice /c yn /m "Do you have python3 installed"

if errorlevel 2 goto install_prereq
if errorlevel 1 goto install_runtime_dependencies


:install_prereq
rem install chocolatey
echo Setting up chocolatey...
set choco_install_dir=%userprofile%\chocolatey
setx ChocolateyInstall %choco_install_dir%

powershell -NoProfile -ExecutionPolicy Bypass -Command "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1" && set PATH="%PATH%;%choco_install_dir%\bin"
echo.

rem install python3
echo Setting up python3...
choco install python
echo.

rem install pip
echo setting up pip
python -m pip install -U pip
echo.


:install_runtime_dependencies
call :print_title Development dependencies setup
choice /c yn /m "Do you wish to install ytd.py for development"

if errorlevel 2 (
    echo intalling production dependencies...
    python -m pip install -r requirements/prod.txt
) else (
    echo intalling development dependencies...
    python -m pip install -r requirements/dev.txt
)


:ffmpeg
set ffmpeg_url=https://ffmpeg.zeranoe.com/builds

call :print_title FFmpeg setup
echo You need to set up ffmpeg for your system
choice /c yn /m "Do you wish to open your browser on the ffmpeg download page"

if errorlevel 2 goto :eof
if errorlevel 1 (
    start "" %ffmpeg_url%
)


goto :eof


:print_title
echo.
echo ------------------------------------------------------
echo %*
echo ------------------------------------------------------
exit /b
