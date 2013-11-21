@echo off
set data=%APPDATA%\youtube-dl

if NOT EXIST "%data%" (
echo Youtube-dl n'est pas install‚ sur cet ordinateur.
goto fin
)

"%data%\main-ydl.bat"

:fin
pause