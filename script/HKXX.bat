set HKXX=%1
set pyver=%2

reg query %HKXX%\SOFTWARE\Python\PythonCore /f "%pyver%"
    if %ERRORLEVEL% EQU 0 (
        reg query %HKXX%\SOFTWARE\Python\PythonCore\%pyver% /f "InstallPath"
        if %ERRORLEVEL% EQU 0 (
            reg query %HKXX%\SOFTWARE\Python\PythonCore\%pyver%\InstallPath /ve > %data%\pypath.tmp
            for /F "usebackq tokens=4" %%i IN ("%data%\pypath.tmp") DO set pypath=%%i
            if EXIST %pypath% IF EXIST %pypath%python.exe set /A "py"+=1" ))