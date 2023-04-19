REM Deletes CDK Shortcut
	del %userprofile%\Desktop\"CDK Drive.lnk"
REM Copies CDK Shortcut to Desktop
:Wait Loop1
	if exist %userprofile%\Desktop\"CDK Drive.lnk" goto:Wait Loop1
	xcopy /y %~d0\SP\"CDK Drive.lnk" C:\%userprofile%\Desktop
	timeout /t 1
REM Copies CDK Shortuct to Public Desktop
:Wait Loop2
	if exist %userprofile%\Desktop\"CDK Drive.lnk" xcopy /y %userprofile%\Desktop\"CDK Drive.lnk" C:\Users\Public\Desktop
	goto:Wait Loop2
	