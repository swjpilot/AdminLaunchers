@echo off
set app="%ProgramFiles%\PowerShell\7\pwsh.exe"
set appArgs=""

CALL %~dp0LauncherConfig.bat
pushd %robPath%
runasspc.exe /cryptfile:"%cryptPath%\%~n0.spc" /program:%app% /domain:%adminDomain% /user:%adminUser% /password:%adminPass% /executein:%workingDir% /param:%appArgs%
runasrob.exe /cryptfile:"%cryptPath%\%~n0.spc"
popd
