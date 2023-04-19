@echo off
REM Local Variables
    set begin = "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
    set temp = "%userprofile%\AppData\Local\Temp"
    set folder = C:\Apps
    set adobe =  C:\Apps\Adobe Reader DC\Adobe
    set bomgar = C:\Apps\BOMGAR Elevated Permisions
    set carbon = C:\Apps\Carbon Black Installer
    set cprofile = C:\Apps\Cisco Any Connect Profile
    set cprofile1 = C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile
    set cinstall = C:\Apps\Cisco AnyConnect installer
    Set ServiceName=vpnagent
    set chrome = C:\Apps\Google Chrome
    set office = C:\Apps\Microsoft Office\Office 365\ODT
    set tableau = C:\Apps\Tableau Reader 10.4 Install
    set tableaudt = C:\Users\Public\Desktop\Tableau Reader 2020.3.lnk
    set installf = C:\Apps
    set desk = %userprofile%\Desktop
REM Checks if computer has been rebooted and copies script into start
    if exist "%temp%\round1.txt" GOTO ROUND1
    xcopy "C:\Apps\CMK Install.cmd" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\" /y /q
REM Main
    REM Used for end of installation to reboot then delete all files
        echo "R1">%temp%\round1.txt
        @echo off
    REM Moves to App folder
        cd C:\Apps
    REM Install Adobe
        "C:\Apps\Adobe Reader DC\Adobe\Setup.exe"
    REM Install Bomgar
        "C:\Apps\BOMGAR Elevated Permisions\bomgar-elvsvc-win64.msi" /quiet
    REM Install Cisco Anyconnect
        "C:\Apps\Cisco AnyConnect installer\anyconnect-win-4.8.03052-core-vpn-predeploy-k9.msi" /quiet
    REM Copy Profile for Cisco Anyconnect
            :L1
            SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul
            echo %ERRORLEVEL%
            if %ERRORLEVEL% EQU 0 GOTO L1
                echo %ServiceName% is running
            xcopy /y /i "C:\Apps\Cisco Any Connect Profile\AnyConnectProfile.xsd" "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
            xcopy /y /i  "C:\Apps\Cisco Any Connect Profile\corpGenPop.xml" "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
            @echo off
            timeout /T 1>nul
    REM Install Google Chrome
        "C:\Apps\Google Chrome\ChromeStandaloneSetup64.exe" /silent /install
    REM Install Microsoft Office
        timeout /T 1
        cd "C:\Apps\Microsoft Office\Office 365\ODT"
        setup.exe" /configure installOfficeProPlus64.xml
        timeout /T 5 /NOBREAK
        CD C:\Apps
    REM Install Tableau Reader
        "%C:\Apps\Tableau Reader 10.4 Install\TableauReader-64bit-2020-3-2.exe" /silent /norestart /log /install ACCEPTEULA=1 STARTMENUSHORTCUT=1 DESKTOPSHORTCUT=1
        :Wait1
            if exist "C:\Users\Public\Desktop\Tableau Reader 2020.3.lnk" GOTO Nxt
        GOTO Wait1
        :Nxt
    REM Install Carbon Black
        msiexec /q /i "C:\Apps\Carbon Black Installer\installer_vista_win7_win8-64-3.4.0.1097.msi" /L* cb_install_log.txt COMPANY_CODE=CEA82RE7WWGBKIC5WM@
    REM Restart
        :RSTRT
            shutdown /r /t 0
            exit 
    REM Sartup
        :ROUND1
            REM Sets Chrome as default browser
                SetDefaultBrowser.exe HKLM "Google Chrome"
            REM Delete installer folder
                del C:\Apps /q /f
            REM Checks if folder is gone
                :Wait2
                    if exist C:\Apps echo  "Install Folder has been deleted!"
                        GOTO Wait2
        timeout /T 1>nul
        @echo off
        cls
        cd "%userprofile%\Desktop"
        wmic /OUTPUT:Software.txt product get name
        cls
        title   Setup Completed!!!
        echo ****************************************************************************************************************************
        echo *"Computer has finished the automated section, please check desktop for a Software.txt file of all programs are installed!"*
        echo ****************************************************************************************************************************
        Pause
        if exist "%temp%\round1.txt" del "%temp%\round1.txt"
        if exist "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\CMK Install.cmd" del "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\CMK Install.cmd"
        exit