:@ECHO OFF
COLOR 0A
C:\Program Files\WindowsPowerShell\powershell.exe -executionpolicy bypass - file "D:\autopilot_info_uploader_new.ps1"
:WaitLoop	
	tasklist /FI "powershell.exe" 2>NUL | find /I /N "powershell.exe">NUL
	if "%ERRORLEVEL%"=="0" GOTO WaitLoop
	GOTO:SystemPrep
:SystemPrep
	%windir%\System32\Sysprep\sysprep.exe /reboot /oobe
Exit