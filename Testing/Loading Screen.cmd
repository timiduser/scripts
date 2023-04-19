@echo off
:REPEAT
cls
echo "Waiting on reboot|-|"			
timeout /T 1 >nul 
cls
echo "Waiting on reboot|--|"
timeout /T 1 >nul 
cls
echo "Waiting on reboot|---|"
timeout /T 1 >nul
GOTO REPEAT
Pause