@echo off
setlocal

set "ROPFOLDER=%USERPROFILE%\.ROSharp"

echo Installing RO-Sharp...

:: Creaza folderul daca nu exista
if not exist "%ROPFOLDER%" mkdir "%ROPFOLDER%"

:: Copiaza interpretorul din folderul curent
if not exist "%~dp0interpretor.py" (
    echo EROARE: Nu gasesc interpretor.py langa acest fisier .bat
    echo Asigura-te ca install-windows.bat si interpretor.py sunt in acelasi folder!
    pause
    exit /b 1
)

copy "%~dp0interpretor.py" "%ROPFOLDER%\interpretor.py" >nul
echo Interpretor copiat cu succes!

:: Copiaza iconita daca exista
if exist "%~dp0ro-sharp.ico" (
    copy "%~dp0ro-sharp.ico" "%ROPFOLDER%\ro-sharp.ico" >nul
    echo Iconita copiata cu succes!
) else (
    echo ATENTIE: ro-sharp.ico nu a fost gasit, fisierele .rop nu vor avea iconita.
)

:: Adauga un script wrapper "rop.bat" in folderul ROSharp
echo @echo off > "%ROPFOLDER%\rop.bat"
echo python3 --version ^>nul 2^>^&1 >> "%ROPFOLDER%\rop.bat"
echo if %%errorlevel%% == 0 ( >> "%ROPFOLDER%\rop.bat"
echo     python3 "%ROPFOLDER%\interpretor.py" %%* >> "%ROPFOLDER%\rop.bat"
echo     exit /b >> "%ROPFOLDER%\rop.bat"
echo ) >> "%ROPFOLDER%\rop.bat"
echo python "%ROPFOLDER%\interpretor.py" %%* >> "%ROPFOLDER%\rop.bat"

:: Adauga folderul la PATH (persista dupa restart)
for /f "skip=2 tokens=3*" %%a in ('reg query HKCU\Environment /v PATH 2^>nul') do set "OLDPATH=%%a %%b"
echo %OLDPATH% | find /i "%ROPFOLDER%" >nul
if errorlevel 1 (
    setx PATH "%OLDPATH%;%ROPFOLDER%" >nul
    echo PATH actualizat!
) else (
    echo Folderul era deja in PATH.
)

:: Asociaza extensia .rop cu iconita si interpretorul
echo Asociez extensia .rop...

:: Inregistreaza tipul de fisier
reg add "HKCU\Software\Classes\.rop" /ve /d "ROSharp.File" /f >nul
reg add "HKCU\Software\Classes\ROSharp.File" /ve /d "RO-Sharp Program" /f >nul

:: Seteaza iconita
if exist "%ROPFOLDER%\ro-sharp.ico" (
    reg add "HKCU\Software\Classes\ROSharp.File\DefaultIcon" /ve /d "%ROPFOLDER%\ro-sharp.ico" /f >nul
    echo Iconita asociata cu .rop!
)

:: Seteaza comanda de executie la dublu-click
reg add "HKCU\Software\Classes\ROSharp.File\shell\open\command" /ve /d "python \"%ROPFOLDER%\interpretor.py\" \"%%1\"" /f >nul

:: Reseteaza cache-ul de iconite Windows
ie4uinit.exe -show >nul 2>&1

echo.
echo ====================================
echo  Instalare completa!
echo  Redeschide terminalul si scrie:
echo    rop fisier.rop
echo  Fisierele .rop vor avea iconita
echo  si se pot rula cu dublu-click!
echo ====================================
pause