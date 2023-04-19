@echo off
REM Local Variables
    set temp = "%userprofile%\AppData\Local\Temp"
    set ServiceName=vpnagent
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
    REM Install Adobe
        start "" /wait "C:\Apps\Adobe Reader DC\Adobe\Setup.exe"
    REM Install Bomgar
        start "" /wait msiexec.exe /i "C:\Apps\BOMGAR Elevated Permisions\bomgar-elvsvc-win64.msi" /quiet
    REM Install Cisco Anyconnect
        start "" /wait msiexec.exe /i "C:\Apps\Cisco AnyConnect installer\Anyconnect-win-4.8.03052-predeploy-k9\anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi" /quiet
        REM Copy Profile for Cisco Anyconnect
            :L1
            SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul
            echo %ERRORLEVEL%
            if %ERRORLEVEL% EQU 0 GOTO L1
                echo %ServiceName% is running
            xcopy /y /i "C:\Apps\Cisco Any Connect Profile\AnyConnectProfile.xsd" "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
            xcopy /y /i  "C:\Apps\Cisco Any Connect Profile\corpGenPop.xml" "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
            @echo off
            timeout /T 1
    REM Install Global Protect
        start "" /wait msiexec.exe /i "C:\Apps\Global Protect\GlobalProtect64.msi" /qn /quiet PORTAL="gp.crossmark.com"
    REM Install Google Chrome
        start "" /wait "C:\Apps\Google Chrome\ChromeStandaloneSetup64.exe" /silent /install
    REM Install Microsoft Office
        timeout /T 1
        cd "C:\Apps\Microsoft Office\Office 365\ODT"
        start "" /wait setup.exe /configure installOfficeProPlus64.xml
        timeout /T 5 /NOBREAK
        CD C:\Apps
    REM Install Tableau Reader
        start "" /wait "%C:\Apps\Tableau Reader 10.4 Install\TableauReader-64bit-2020-3-2.exe" /silent /norestart /log /install ACCEPTEULA=1 STARTMENUSHORTCUT=1 DESKTOPSHORTCUT=1
        :Wait1
            if exist "C:\Users\Public\Desktop\Tableau Reader 2020.3.lnk" GOTO Nxt
        GOTO Wait1
        :Nxt
    REM Setup Global Protect Pre Login
        cd "C:\Program Files\Palo Alto Networks\GlobalProtect" 
        start "" /wait pangps.exe -registerplap
    REM Install Carbon Black
        start "" /wait msiexec /q /i "C:\Apps\Carbon Black Installer\installer_vista_win7_win8-64-3.8.0.684.msi" /L* cb_install_log.txt COMPANY_CODE=CEA82RE7WWGBKIC5WM@
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