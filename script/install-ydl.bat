@echo off
chdir > ddata.tmp
SET /p data=<ddata.tmp
del ddata.tmp
set ydata=%APPDATA%\youtube-dl
set ydir=%USERPROFILE%\Videos\youtube-dl

if NOT EXIST "%ydata%" ( mkdir "%ydata%" ) else ( goto conflit )

echo Proc‚der … l'installation de youtube-dl?
echo     o.oui
echo     n.non
"%data%\choice" /C:on /N "Faites votre choix: "

if %ERRORLEVEL%==1 goto install
if %ERRORLEVEL%==2 goto fin

:conflit
echo Youtube-dl est deja install‚.
echo     R. R‚installer
echo     U. D‚sinstaller
echo     C. Annull‚

"%data%\choice" /C:ruc /N "Faites votre choix: "

if %ERRORLEVEL%==1 goto repair
if %ERRORLEVEL%==2 goto uninstall
if %ERRORLEVEL%==3 goto fin

:repair
echo R‚installation:    ‚tape 1/2:
echo     d‚sinstallation....
rmdir /S /Q "%ydata%"
mkdir "%ydata%"
echo d‚sintallation termin‚e.
echo                    ‚tape 2/2:
echo     installation....
goto install

:uninstall
echo D‚sinstallation:   ‚tape 1/1:
echo     d‚sinstallation....
rmdir /S /Q "%ydata%"
echo d‚sintallation termin‚e.
goto fin

:install
echo Installation:      ‚tape 1/3
echo     cr‚ation du dossier de r‚ception (si non existant) … l'emplacement:
echo         %ydir%
if NOT EXIST "%ydir%" ( mkdir "%ydir%" )
echo                    ‚tape 2/3
echo     copie des fchiers....
copy "%data%\*" "%ydata%\"
del /Q "%ydata%\install-dl.bat"
echo copie termin‚e.
echo                    ‚tape 3/3
echo     copie de l'‚xecutable dans votre r‚pertoire personnel....
move /Y "%ydata%\youtube-dl.exe" "%USERPROFILE%\"
echo copie termin‚e.
echo Installation termin‚e.

:fin
pause
