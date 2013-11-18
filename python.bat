reg query HKCU\SOFTWARE /f "Python"
if %ERRORLEVEL% EQU 0 (
    reg query HKCU\SOFTWARE\Python /f "PythonCore"
    if %ERRORLEVEL% EQU 0 (
        reg query HKCU\SOFTWARE\Python\PythonCore /f "2.7"
        if %ERRORLEVEL% EQU 0 (
            reg query HKCU\SOFTWARE\Python\PythonCore\2.7 /f "InstallPath"
            if %ERRORLEVEL% EQU 0 (
                reg query HKCU\SOFTWARE\Python\PythonCore\2.7\InstallPath /ve > %data%\pypath.tmp
                for /F "usebackq tokens=4" %%i IN ("%data%\pypath.tmp") DO set pypath=%%i
                if EXIST %pypath% IF EXIST %pypath%python.exe goto PythOk )))) 

reg query HKCU\SOFTWARE /f "Python"
if %ERRORLEVEL% EQU 0 (
    reg query HKCU\SOFTWARE\Python /f "PythonCore"
    if %ERRORLEVEL% EQU 0 (
        reg query HKCU\SOFTWARE\Python\PythonCore /f "2.7"
        if %ERRORLEVEL% EQU 0 (
            reg query HKCU\SOFTWARE\Python\PythonCore\2.7 /f "InstallPath"
            if %ERRORLEVEL% EQU 0 (
                reg query HKCU\SOFTWARE\Python\PythonCore\2.7\InstallPath /ve > %data%\pypath.tmp
                for /F "usebackq tokens=4" %%i IN ("%data%\pypath.tmp") DO set pypath=%%i
                if EXIST %pypath% IF EXIST %pypath%python.exe goto PythOk )))) 


:0
return 0;

:PythOk
return 1;
