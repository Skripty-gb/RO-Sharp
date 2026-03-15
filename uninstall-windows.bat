@echo off
echo ====================================
echo  Dezinstalare RO-Sharp
echo ====================================
echo.
set /p CONFIRM="Esti sigur ca vrei sa stergi RO-Sharp? (da/nu): "
if /i not "%CONFIRM%"=="da" (
    echo Dezinstalare anulata.
    pause
    exit /b 0
)

echo Dezinstalare in curs...

:: Sterge folderul de instalare
if exist "%USERPROFILE%\.ROSharp" (
    rmdir /s /q "%USERPROFILE%\.ROSharp"
    echo Folder .ROSharp sters.
) else (
    echo Folderul .ROSharp nu a fost gasit.
)

:: Sterge asocierea extensiei .rop din registry
reg delete "HKCU\Software\Classes\.rop" /f >nul 2>&1
reg delete "HKCU\Software\Classes\ROSharp.File" /f >nul 2>&1
echo Asocierea .rop stearsa din registry.

:: Sterge din PATH
for /f "skip=2 tokens=3*" %%a in ('reg query HKCU\Environment /v PATH 2^>nul') do set "OLDPATH=%%a %%b"
set "NEWPATH=%OLDPATH:.ROSharp;=%"
set "NEWPATH=%NEWPATH:;.ROSharp=%"
setx PATH "%NEWPATH%" >nul
echo PATH actualizat.

ie4uinit.exe -ClearIconCache >nul 2>&1

echo.
echo ====================================
echo  RO-Sharp a fost dezinstalat!
echo  La revedere!
echo ====================================
pause
