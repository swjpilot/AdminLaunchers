@echo off
copy /Y %~dp0mmc.bat %~dp0adminPackage\
copy /Y %~dp0adac.bat %~dp0adminPackage\
copy /Y %~dp0LauncherConfig-Blank.bat %~dp0adminPackage\LauncherConfig.bat
copy /Y %~dp0pwsh-admin.bat %~dp0adminPackage\
copy /Y %~dp0powershell-admin.bat %~dp0adminPackage\
copy /Y %~dp0install.bat %~dp0adminPackage\
copy /Y %~dp0install.ps1 %~dp0adminPackage\
pushd %~dp0
del Installer.7z
del AdminPackageInstaller.exe
pushd .\adminPackage
C:\ProgramData\chocolatey\bin\7z.EXE a -y ..\Installer.7z .\*
popd
copy /b 7zSD.sfx + config.txt + Installer.7z AdminPackageInstaller.exe
popd