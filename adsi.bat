@echo off
CALL %~dp0LauncherConfig.bat
C:\Windows\System32\runas.exe /profile /user:%adminUser% /savecred "c:\windows\system32\mmc.exe c:\windows\system32\adsiedit.msc" < echo %adminpass%
