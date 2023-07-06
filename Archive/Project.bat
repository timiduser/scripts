@echo off
REM Variables for script(change site domain per project)
    set site=adpnwms1.sonic.com
    set short="Drive - North West Motorsports"
    set P1= "C:\Users\Public\Desktop"
REM Input for computer name
    REM Checks what round it is and goes to proper section of code
        if exist %userprofile%\AppData\Local\Temp\"round3.txt" GOTO Finish
        if exist %userprofile%\AppData\Local\Temp\"round2.txt" GOTO ROUND3
        if exist %userprofile%\AppData\Local\Temp\"round1.txt" GOTO ROUND2
 REM First round   
    :input
        set /p MYNAME="New Computer Name: "
        if exist %userprofile%\AppData\Local\Temp\"round1.txt" del "R1">%userprofile%\AppData\Local\Temp\round1.txt
        @echo off
        title Changing naming convention!
        REM Copies files locally
            @echo off
            xcopy %~d0\SP\Project.bat "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup" /y /q
            xcopy %~d0\SP\"4 - Agent_Install.exe" "%userprofile%\AppData\Local\Temp\" /y /q
            xcopy %~d0\SP\Domain\DomainJoin.ps1 "%userprofile%\AppData\Local\Temp\" /y /q
            xcopy %~d0\SP\"CDK Drive.url" "%userprofile%\AppData\Local\Temp\" /y /q
            xcopy %~d0\SP\"WSPCP_EXP" "%userprofile%\AppData\Local\Temp\WSPCP_EXP" /e /h /c /i /y /q
        REM Create a temp file for reboot
            echo "R1">%userprofile%\AppData\Local\Temp\round1.txt
        REM Verifying naming convention
            cls
            echo "Changing computer name from: %COMPUTERNAME% to new computer name: %MYNAME%"
            SET /P AREYOUSURE=Are you sure (Y/[N])?
                if /I "%AREYOUSURE%" NEQ "Y" GOTO input
                    GOTO CHANGE
        REM Chaninging naming convention
            :CHANGE
                WMIC ComputerSystem where Name="%COMPUTERNAME%" call Rename name="%MYNAME%" |find "ReturnValue = 0;" >nul && GOTO RESTART
                    GOTO WARNING
            :WARNING
                echo "Computer did not name properly, please check the above error and try again."
                Pause
                GOTO Issue
            :RESTART
                shutdown /r /t 0
                Pause
REM Second round
    :ROUND2
        @echo off
        title CDK and Connectwise Installation
        REM Removes file from round 1
            del %userprofile%\AppData\Local\Temp\round1.txt /q
        REM Create a temp file for reboot
            echo "R2">%userprofile%\AppData\Local\Temp\round2.txt
        REM Runs Connectwise Installer
	        start %userprofile%\AppData\Local\Temp\"4 - Agent_Install.exe"
        REM Goes to CDK installer
            :CDK
                start %userprofile%\AppData\Local\Temp\WSPCP_EXP\"StartInstaller.exe"
                echo "Did CDK install properly?"
                SET /P AREYOUSURE=Are you sure (Y/[N])?
                    if /I "%AREYOUSURE%" NEQ "Y" GOTO CDK
                        :REPEAT
                            cls
                            echo "Waiting on reboot."
                            timeout /T 1>nul
                            cls
                            echo "Waiting on reboot.."
                            timeout /T 1>nul
                            cls
                            echo "Waiting on reboot..."
                            timeout /T 1>nul
                            GOTO REPEAT
                        Pause
            exit
REM Third round
    :ROUND3
        @echo off
        title CDK and Domain Join
        REM Removes file from round 1
            del %userprofile%\AppData\Local\Temp\round2.txt /q
        REM Create a temp file for reboot
            echo "R3">%userprofile%\AppData\Local\Temp\round3.txt
        REM Deletes CDK Shortcut
	        if exist %P1%\"CDK Drive.lnk" del %P1%\"CDK Drive.lnk"
        REM Copies CDK Shortcut to Public Desktop
            :Wait
                cls
	            if exist %P1%\"CDK Drive.lnk" GOTO:Wait
	            xcopy /y /i %userprofile%\AppData\Local\Temp\"CDK Drive.url" %P1%
                ren %P1%\"CDK Drive.url" %short%.url
	            timeout /t 1
        REM Domain joins the computer
	        Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\DomainJoin.ps1
            Pause
            exit
REM End of Function
    :Finish
        if exist %userprofile%\AppData\Local\Temp\round1.txt del %userprofile%\AppData\Local\Temp\round1.txt /q
        if exist %userprofile%\AppData\Local\Temp\round2.txt del %userprofile%\AppData\Local\Temp\round2.txt /q
        if exist %userprofile%\AppData\Local\Temp\round3.txt del %userprofile%\AppData\Local\Temp\round3.txt /q
        if exist %userprofile%\AppData\Local\Temp\"4 - Agent_Install.exe" del %userprofile%\AppData\Local\Temp\"4 - Agent_Install.exe" /q
        if exist %userprofile%\AppData\Local\Temp\"DomainJoin.ps1"  del %userprofile%\AppData\Local\Temp\"DomainJoin.ps1" /q
        if exist %userprofile%\AppData\Local\Temp\"CDK Drive.lnk" del %userprofile%\AppData\Local\Temp\"CDK Drive.lnk"/q
        cls
        @echo off
        title   Setup Completed!!!
        echo ***********************************************************************************************************
        echo "Computer has finished the automated section, please review the below information before pressing any key!"
        echo ***********************************************************************************************************
        echo %ComputerName%
        systeminfo | findstr /B "Domain"
        Pause
        if exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\"Project.bat del "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\"Project.bat /q
        exit
 REM Deletes files if error occurs during naming
    :Issue
        if exist %userprofile%\AppData\Local\Temp\round1.txt del %userprofile%\AppData\Local\Temp\round1.txt /q
        if exist %userprofile%\AppData\Local\Temp\round2.txt del %userprofile%\AppData\Local\Temp\round2.txt /q
        if exist %userprofile%\AppData\Local\Temp\round3.txt del %userprofile%\AppData\Local\Temp\round3.txt /q
        if exist %userprofile%\AppData\Local\Temp\"4 - Agent_Install.exe" del %userprofile%\AppData\Local\Temp\"4 - Agent_Install.exe" /q
        if exist %userprofile%\AppData\Local\Temp\"DomainJoin.ps1"  del %userprofile%\AppData\Local\Temp\"DomainJoin.ps1" /q
        if exist %userprofile%\AppData\Local\Temp\"CDK Drive.lnk" del %userprofile%\AppData\Local\Temp\"CDK Drive.lnk"
        RMDIR %userprofile%\AppData\Local\Temp\WSPCP_EXP /s /q
        if exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\"Project.bat del "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\"Project.bat /q
        exit