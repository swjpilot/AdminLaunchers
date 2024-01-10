@echo off
set app="%windir%\system32\mmc.exe"
set appArgs="%windir%\system32\%1.msc"

CALL %~dp0LauncherConfig.bat
pushd %robPath%
runasspc.exe /cryptfile:"%cryptPath%\%1.spc" /program:%app% /domain:%adminDomain% /user:%adminUser% /password:%adminPass% /executein:%workingDir% /param:%appArgs%
runasrob.exe /cryptfile:"%cryptPath%\%1.spc"
popd