@echo off
echo Administrative permissions required. Detecting permissions...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
    goto install
) else (
    echo Failure: Current permissions inadequate.
    CALL %~dp0\RunElevated.exe %~dp0\install.bat
    exit
)

:install
mkdir C:\ProgramData\AdminLaunchers
copy %~dp0\*.* C:\ProgramData\AdminLaunchers
copy %~dp0\*.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools"
powershell -f %~dp0install.ps1
msiexec.exe /package %~dp0PowerShell-7.4.0-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1
notepad "C:\ProgramData\AdminLaunchers\LauncherConfig.bat"