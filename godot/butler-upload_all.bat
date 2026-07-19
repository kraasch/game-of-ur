@echo off

REM Itch.io details.
set ITCH_USERNAME=kraasch
set ITCH_GAME_ID=ur
REM set BUTLER_PATH=C:\Tools\butler\butler.exe
set BUTLER_PATH=butler
set BUILD_DIR=builds

REM Define builds.
set WIN_BUILD=%BUILD_DIR%\windows
set LIN_BUILD=%BUILD_DIR%\linux
set WEB_BUILD=%BUILD_DIR%\web

REM Upload builds.
"%BUTLER_PATH%" push "%WIN_BUILD%" "%ITCH_USERNAME%/%ITCH_GAME_ID%:windows"
"%BUTLER_PATH%" push "%LIN_BUILD%" "%ITCH_USERNAME%/%ITCH_GAME_ID%:linux"
"%BUTLER_PATH%" push "%WEB_BUILD%" "%ITCH_USERNAME%/%ITCH_GAME_ID%:web"

echo All builds uploaded.
pause
