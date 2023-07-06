@echo off
REM Variables for script(change site domain per project)
    set site=adpnwms1.sonic.com
    set short="Drive - North West Motorsports"
    set P1= "C:\Users\Public\Desktop"
    xcopy %~d0\SP\"CDK Drive.url" "%userprofile%\AppData\Local\Temp\" /y /q
REM Deletes CDK Shortcut
	        if exist %P1%\"CDK Drive.lnk" del %P1%\"CDK Drive.lnk"
        REM Copies CDK Shortcut to Public Desktop
            :Wait
                cls
	            if exist %P1%\"CDK Drive.lnk" GOTO:Wait
	            xcopy /y /i %userprofile%\AppData\Local\Temp\"CDK Drive.url" %P1%
                ren %P1%\"CDK Drive.url" %short%.url
	            timeout /t 1
                Pause