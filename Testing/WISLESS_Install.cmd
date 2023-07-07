@echo off
color 0a
REM Local Variables
    set everyone=%public%\Desktop
    set apps=C:\Apps
    set post=C:\Apps\Post
REM Checks if computer has been rebooted and copies script into start
    timeout /T 15 /NOBREAK
    if exist "%temp%\round2.txt" GOTO REMOVAL    
    if exist "%temp%\round1.txt" GOTO FIN
REM Main
    REM Used for end of installation to reboot then delete all files
        echo "R1">%temp%\round1.txt
        @echo off
    REM Moves to App folder
        cd C:\Apps
    REM Install BGInfo
        cls
        echo Setting up BGInfo
        @echo off
        md "C:\Windows\BGInfo"
        xcopy "%post%\BGInfo\" "C:\Windows\BGInfo" /y /q /s /h
        attrib -h "C:\Windows\BGInfo" /s /d
        attrib -h "C:\Windows\BGInfo\*.*" /s
        xcopy "%post%\BGInfo\BGinfo.lnk" "%everyone%"
    REM AFAPPS.ICO Move
        xcopy "%post%\AFAPPS.ICO" "%systemroot%" /y /q /h | attrib -h "%systemroot%\AFAPPS.ICO"
    REM Move desktop shortcuts
        cls
        echo Placing desktop shortcuts.
        @echo off
        xcopy "%post%\Desktop Shortcuts\Helpdesk.url" "%everyone%" /y /q /h | attrib -h "%everyone%\Helpdesk.url"
        xcopy "%post%\Desktop Shortcuts\HR - Accounting - Edge.lnk" "%everyone%" /y /q /h | attrib -h "%everyone%\HR - Accounting - Edge.lnk"
        xcopy "%post%\Desktop Shortcuts\Inventory Operations - Edge.lnk" "%everyone%" /y /q /h | attrib -h "%everyone%\Inventory Operations - Edge.lnk"
    REM Install Zoho
        cls
        echo Installing Zoho, please wait while this is being completed.
        @echo off
        start "" /wait msiexec.exe /i "%post%\Zoho\ZA_Access.msi" /q SILENT=TRUE
    REM Install Certificates
        cls
        echo Installing security certificates, please wait while this is being completed.
        @echo off
        certutil -addstore -enterprise "root" "%post%\RGIS Root CA.cer"
        certutil -addstore -enterprise "root" "%post%\WIS-ADCS-CA-01.western-inventory.com_Root.cer"
    REM Install Java
        cls
        echo Installing Java, please wait while this is being completed.
        @echo off
        start "" /wait "%post%\jre-7u45-windows-i586.exe" /s
    REM Install Trend Micro AV
        cls
        echo Installing Trend Micro AV, please wait while this is being completed.
        @echo off
        start "" /wait "%post%\Trend Micro standalone agent\VC_redist.x86.exe" /q /norestart
        start "" /wait "%post%\Trend Micro standalone agent\agent_cloud_x64.msi" /quiet /norestart
    REM Install Global Protect
        echo Installing Global Protect, please wait while this is being completed.
        @echo off
        start "" /wait msiexec.exe /i "%post%\Global Protect\GlobalProtect64.msi" /qn PORTAL="connect.wisintl.com"
        timeout /T 10
    REM Add to startup
        :STRT
        REM    xcopy "C:\Apps\WISLESS_Install.cmd" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\" /y /q
        REM    timeout /t 5 /NOBREAK
    REM Verifying and Cleanup
        :FIN
            timeout /T 5
            start /wait Powershell.exe -executionpolicy remotesigned -File  C:\Apps\Post\MSAPPS.ps1
            timeout /T 5
    REM Cleanup
            if exist "%temp%\round1.txt" del "%temp%\round1.txt"
            timeout /T 5
            echo "R2">%temp%\round2.txt
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
            if exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\WISLESS_Install.cmd" del "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\WISLESS_Install.cmd"
    REM To reset Global Protect as it doesn't detect profile on first launch 100% of the time
            taskkill /F /IM PanGPA.exe /T
    REM Domain Join
        :DJ
            cls
            echo Please sign into GlobalProtect with your credetials at this time!
            @echo off
            :Loop
                timeout /T 1
                ping 172.19.200.91 -n 1 | find /i "TTL=" || GOTO Loop
            cls
            echo Thank you for signing into GlobalProtect. Now moving onto domain join.
            @echo off
            start /wait Powershell.exe -executionpolicy remotesigned -File  C:\Apps\Post\WISLESS_DomainJoin.ps1
            timeout /T 5
exit