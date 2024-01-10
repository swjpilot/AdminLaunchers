@echo off
set app="c:\windows\system32\mmc.exe"
set appArgs=""
set workingDir="D:\Users\johns"

CALL %~dp0LauncherConfig.bat
pushd %robPath%
runasspc.exe /cryptfile:"%cryptPath%\%~n0.spc" /program:%app% /domain:%adminDomain% /user:%adminUser% /password:%adminPass% /executein:%workingDir% /param:%appArgs%
runasrob.exe /cryptfile:"%cryptPath%\%~n0.spc"
popd