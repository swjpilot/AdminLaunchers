@echo off
CALL %~dp0LauncherConfig.bat
%robPath%\RunasRob.exe /cryptfile:%cryptfile%  "c:\windows\system32\mmc.exe c:\windows\system32\dnsmgmt.msc"
