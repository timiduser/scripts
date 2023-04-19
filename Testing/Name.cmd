@echo off

:input
set /p MYNAME="New Computer Name: "


REM Verifying naming convention
echo "Changing computer name from: %COMPUTERNAME% to new computer name: %MYNAME%"
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO input
GOTO CHANGE

REM Chaninging naming convention

:CHANGE
WMIC ComputerSystem where Name="%COMPUTERNAME%" call Rename name=%MYNAME%

IF %ERRORLEVEL% NEQ "0" GOTO WARNING
GOTO RESTART

:WARNING
echo "Computer did not name properly, please verify if name is correct after reboot."
Pause

:RESTART
shutdown /r /t 0