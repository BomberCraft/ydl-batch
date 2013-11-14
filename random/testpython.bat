@echo off
reg query HKLM\SOFTWARE /f "Python"
if %ERRORLEVEL% EQU 0 (
reg query HKLM\SOFTWARE\Python /f "PythonCore"
if %ERRORLEVEL% EQU 0 (
reg query HKLM\SOFTWARE\Python\PythonCore /f "2.7"
if %ERRORLEVEL% EQU 0 (
reg query HKLM\SOFTWARE\Python\PythonCore\2.7 /f "PythonPath"
if %ERRORLEVEL% EQU 0 (
goto 1 ))))

reg query HKCU\Software /f "Python"
if %ERRORLEVEL% EQU 0 (
reg query HKCU\Software\Python /f "PythonCore"
if %ERRORLEVEL% EQU 0 (
reg query HKCU\Software\Python\PythonCore /f "2.7"
if %ERRORLEVEL% EQU 0 (
reg query HKCU\Software\Python\PythonCore\2.7 /f "PythonPath"
if %ERRORLEVEL% EQU 0 (
goto 1 ))))

goto 0

goto fin

:0
echo Python non installe ou pas a la bonne version installer Python 2.7
goto fin

:1
echo Python est correctement installe
goto fin

:fin
pause
