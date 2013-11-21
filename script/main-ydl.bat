@echo off
cls
set bversion=18.11.2012-0
set eversion=18.11.2012-0
set timeout=10
set url_bversion=https://raw.github.com/BomberCraft/ydl-batch/master/version/bat-version.txt
set url_eversion=https://raw.github.com/BomberCraft/ydl-batch/master/version/exe-version.txt
set data=%APPDATA%\youtube-dl
set ydir=%USERPROFILE%\Videos\youtube-dl
set exec=youtube-dl.py
set previous=%CD%
set param=--verbose --console-title --ignore-error --restrict-filenames

if NOT EXIST "%data%" (
echo Youtube-dl n'est pas install‚ sur cet ordinateur.
goto fin
)

call python.bat

if %ERRORLEVEL%==0 goto 0
if %ERRORLEVEL%==1 goto PythOk

:0
cls
echo Python non install‚ ou pas a la bonne version‚ installer Python 2.7 ou sup‚rieur
goto fin

:PythOk
cls
if NOT EXIST "%ydir%" ( mkdir "%ydir%" )
if NOT EXIST "%ydir%\audio" ( mkdir "%ydir%\audio" )

cd %ydir%

:debut
echo t. T‚l‚chargement classique
echo s. T‚l‚chargement avec option (youtube seulement)
echo a. Extraire le son de la vid‚o
echo d. Divers
echo o. Option
echo u. D‚sinstaller
echo q. Quitter

"%data%\choice" /C:tsadouq /N "Faites votre choix: "
echo.

if %ERRORLEVEL%==1 goto classic
if %ERRORLEVEL%==2 goto special
if %ERRORLEVEL%==3 goto audio
if %ERRORLEVEL%==4 goto divers
if %ERRORLEVEL%==5 goto option
if %ERRORLEVEL%==6 goto uninstall
if %ERRORLEVEL%==7 goto fin

goto debut

:classic
set /p lien="Entrez le lien de la vid‚o: "
"%data%\%exec%" %param% -t "%lien%"
goto fin

:special
:vformat
set /p lien="Entrez le lien de la vid‚o: "
"%data%\%exec%" -F "%lien%" 2>NULL
if %ERRORLEVEL%==1 goto selse

:soption
set /p vformat="S‚lectionner le code format(premiŠre colonne): "

:subtitle
"%data%\choice" /C:on /T:n,%timeout% "T‚l‚charger les sous-titres? (defaut:non) (%timeout%s): "

if %ERRORLEVEL%==1 goto srt 

"%data%\%exec%" %param% -t -f %vformat% "%lien%"
goto fin

:srt
"%data%\choice" /C:on /T:n,%timeout% "Modifier la langue par d‚faut? (%timeout%s): "

if %ERRORLEVEL%==1 goto lsrt  

"%data%\%exec%" %param% -t -f %vformat% --write-sub "%lien%"
goto fin

:lsrt
"%data%\choice" /C:on /T:n,%timeout% "Afficher les langues disponible? (%timeout%s): "
if %ERRORLEVEL%==1 "%data%\%exec%" %param% --list-subs "%lien%"

set /p lang="Choisiser la langue des sous-titres (utiliser IETF language tags: en,fr,...): "
"%data%\%exec%" %param% -t -f %vformat% --write-sub --sub-lang "%lang%" "%lien%"
goto fin

:selse
"%data%\%exec%" %param% -t "%lien%"
goto fin

:audio
set /p lien="Entrez le lien de la vid‚o: "
set format=best
set quality=5

:aformat
"%data%\choice" /C:on /T:n,%timeout% "Modifier le format audio par d‚faut? (defaut:best)(%timeout%s): "

if %ERRORLEVEL%==2 goto download

echo a. Best format
echo b. .aac
echo c. .ogg
echo d. .mp3
echo e. .m4a
echo f. .wav
echo r. Retour
echo q. Quitter

"%data%\choice" /C:abcdefrq /N "Choisissez le format audio: "
echo.

if %ERRORLEVEL%==1 set format=best
if %ERRORLEVEL%==2 set format=aac
if %ERRORLEVEL%==3 set format=vorbis
if %ERRORLEVEL%==4 set format=mp3
if %ERRORLEVEL%==5 set format=m4a
if %ERRORLEVEL%==6 set format=wav
if %ERRORLEVEL%==7 goto debut
if %ERRORLEVEL%==8 goto fin

"%data%\choice" /C:0123456789 /N /T:5,%timeout% "Entrer la qualit‚e entre 0(meilleur) et 9(pire) (defaut 5)(%timeout%s): "
set /a quality=%ERRORLEVEL%-1

:download
cd %ydir%\audio
"%data%\choice" /C:on /T:n,%timeout% "Conserver la vid‚o?(defaut:non)(%timeout%s): "
if %ERRORLEVEL%==1 goto download-k

"%data%\%exec%" %param% -t --extract-audio --audio-format %format% --audio-quality %quality% "%lien%"

if %ERRORLEVEL% (
echo.
echo ProblŠme dans l'encodage de la bande audio
echo. )

goto fin

:download-k
"%data%\%exec%" %param% -t -k --extract-audio --audio-format %format% --audio-quality %quality% "%lien%"
"%data%\%exec%" %param% --get-filename "%lien%" > %data%\filename.tmp
set /p filename=<%data%\filename.tmp
del %data%\filename.tmp
if EXIST "%ydir%\audio\%filename%" move /Y "%ydir%\audio\%filename%" %ydir%
goto fin

:option
echo Version du bat: %bversion%
goto test_bversion
:fin_btest
echo Version du bat: %eversion%
goto test_eversion
:fin_etest
"%data%\%exec%" --version > %data%\yversion.tmp
set /p yversion=<%data%\yversion.tmp
del %data%\yversion.tmp
echo Version de youtube-dl: %yversion%
echo.
echo r. Retour
echo q. Quitter

"%data%\choice" /C:rq /N "Faites votre choix:"
echo.

if %ERRORLEVEL%==1 goto debut
if %ERRORLEVEL%==2 goto fin

:test_bversion
"%data%\curl" -k# %url_bversion% -o bversion.tmp
set /p bvertmp=<bversion.tmp
del bversion.tmp
if "%bversion:~6,9%" LEQ "%bvertmp:~6,9%" (
if "%bversion:~3,4%" LEQ "%bvertmp:~3,4%" (
if "%bversion:~0,2%" LEQ "%bvertmp:~0,2%" (
if "%bversion:~11%" LSS "%bvertmp:~11%" (
echo Batch file isn't up to date, last version is %bvertmp%
goto fin_btest ))))
echo Batch file is up to date
goto fin_btest

:test_eversion
"%data%\curl" -k# %url_eversion% -o eversion.tmp
set /p evertmp=<eversion.tmp
del eversion.tmp
if "%eversion:~6,9%" LEQ "%evertmp:~6,9%" (
if "%eversion:~3,4%" LEQ "%evertmp:~3,4%" (
if "%eversion:~0,2%" LEQ "%evertmp:~0,2%" (
if "%eversion:~11%" LSS "%evertmp:~11%" (
echo Executable file isn't up to date, last version is %evertmp%
goto fin_etest ))))
echo Executable file is up to date
goto fin_etest

:divers
echo y. Taper une commande sp‚ciale de youtube-dl
echo h. Afficher l'aide de youtube-dl
echo o. Ouvrir une console de commande
echo r. Retour
echo q. Quitter

"%data%\choice" /C:yhorq /N "Faites votre choix: "
echo.

if %ERRORLEVEL%==1 goto dspecial
if %ERRORLEVEL%==2 start cmd /C "%data%\%exec% --help && pause"
if %ERRORLEVEL%==3 start cmd /K "cd %data%"
if %ERRORLEVEL%==4 goto debut
if %ERRORLEVEL%==5 goto fin
goto divers

:dspecial
set /p argument="Choisisser le(s) argument(s) pour youtube-dl: "
"%data%\%exec%" %argument%
echo.
goto divers

:uninstall
echo D‚sinstallation:	‚tape 1/1:
echo 	d‚sinstallation....
rmdir /S /Q "%data%"
echo d‚sintallation termin‚e.
goto fin

:fin
cd %previous%
pause
