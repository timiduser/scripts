@echo off
set NAME= %COMPUTERNAME%
set /p MYNAME="New Computer Name: "


REM Verifying naming convention
echo "Changing computer name from: %NAME% to new computer name: %MYNAME%"
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO CHANGE

REM Chaninging naming convention

WMIC ComputerSystem where Name="%NAME%" call Rename Name=%MYNAME%

Pause