@echo off
REM Local Variables
    set temp = "%userprofile%\AppData\Local\Temp"
    set everyone = "%public%\Desktop"
    set apps = "C:\Apps"
    set post = "C:\Apps\Post"
REM Checks if computer has been rebooted and copies script into start
    timeout /T 15 /NOBREAK
    if exist "%temp%\round2.txt" GOTO REMOVAL    
    if exist "%temp%\round1.txt" GOTO ROUND3
REM Main
    REM Used for end of installation to reboot then delete all files
        echo "R1">%temp%\round1.txt
        @echo off
    REM Moves to App folder
        cd C:\Apps
    REM Install Global Protect
        start "" /wait msiexec.exe /i "C:\Apps\Global Protect\GlobalProtect64.msi" /qn /quiet PORTAL="connect.wisintl.com"
    REM Install BGInfo
        md "C:\Windows\BGInfo"
        xcopy "%post%\BGInfo\" "C:\Windows\BGInfo" /y /q /s /h
        attrib -h "C:\Windows\BGInfo" /s /d
        attrib -h "C:\Windows\BGInfo\*.*" /s
        xcopy "%post%\BGInfo\BGinfo.lnk" "%everyone%"
    REM AFAPPS.ICO Move
        xcopy "%post%\AFAPPS.ICO" "%systemroot%" | attrib - h "%systemroo%\AFAPPS.ICO"
    REM Move desktop shortcuts
        xcopy "%post%\Desktop Shortcut\Helpdesk.url" "%everyone%" | attrib - h "%everyone%\Helpdesk.url"
        xcopy "%post%\Desktop Shortcut\HR - Accounting - Edge.lnk" | attrib - h "%everyone%\HR - Accounting - Edge.lnk"
        xcopy "%post%\Desktop Shortcut\Inventory Operations - Edge.lnk" | attrib - h "%everyone%\Inventory Operations - Edge.lnk"
    REM Install Zoho
        start "" /wait msiexec.exe /i "%post%\Zoho\ZA_Access.msi" /q SILENT=TRUE
    REM Install Certificates
    REM Install Java
    REM Install Trend Micro AV
    REM Restart
        :RSTRT
            xcopy "C:\Apps\WIS_Install.cmd" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\" /y /q
            timeout /t 5 /NOBREAK
    REM Domain Join
        :DJ
            timeout /T 5
            start /wait Powershell.exe -executionpolicy remotesigned -File  C:\Apps\MSAPPS.ps1
            timeout /T 5
            start /wait Powershell.exe -executionpolicy remotesigned -File  C:\Apps\WIS_DomainJoin.ps1
            timeout /T 5
            exit
    REM Verifying and Cleanup
        :ROUND3
            if exist "%temp%\round1.txt" del "%temp%\round1.txt"
            timeout /T 5
            echo "R2">%temp%\round2.txt
            REM Delete installer folder
                rmdir C:\Apps /q /s
            timeout /T 1
            @echo off
            cls
            cd "%userprofile%\Desktop"
            wmic /OUTPUT:Software.txt product get name
            cls
            title   Setup Completed!!!
            echo ********************************************************************************************************************************
            echo *Computer %ComputerName% has finished the automated section, check desktop for Software.txt file of all programs are installed!*
            echo ********************************************************************************************************************************
            Pause
        :REMOVAL
            if exist "%temp%\round1.txt" del "%temp%\round1.txt"
            if exist "%temp%\round2.txt" del "%temp%\round2.txt"
            if exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\WIS_Install.cmd" del "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\WIS_Install.cmd"
        REM To reset Global Protect as it doesn't detect profile on first launch 100% of the time
        :GPRESET
            taskkill /F /IM PanGPA.exe /T
exit