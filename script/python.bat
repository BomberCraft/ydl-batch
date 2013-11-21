set py=0
                
reg query HKLM\SOFTWARE /f "Python"
if %ERRORLEVEL% EQU 0 (
    reg query HKLM\SOFTWARE\Python /f "PythonCore"
    if %ERRORLEVEL% EQU 0 (
        reg query HKLM\SOFTWARE\Python\PythonCore > "%data%\pyver.tmp"
        for /F "usebackq delimns=\ tokens=5" %%i IN ("%data%\pyver.tmp") DO call "%data%\HKXX.bat" HKLM %%i ))
        
if %py% NEQ 0 goto PythOk
        
reg query HKCU\SOFTWARE /f "Python"
if %ERRORLEVEL% EQU 0 (
    reg query HKCU\SOFTWARE\Python /f "PythonCore"
    if %ERRORLEVEL% EQU 0 (
        reg query HKCU\SOFTWARE\Python\PythonCore > "%data%\pyver.tmp"
        for /F "usebackq delimns=\ tokens=5" %%i IN ("%data%\pyver.tmp") DO call "%data%\HKXX.bat" HKCU %%i ))

if %py% NEQ 0 goto PythOk

:0
IF EXIST %data%\pypath.tmp del "%data%\pypath.tmp"
return 0;

:PythOk
IF EXIST %data%\pypath.tmp del "%data%\pypath.tmp"
return 1;
