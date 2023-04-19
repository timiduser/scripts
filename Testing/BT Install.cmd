@echo off
REM Local Variables
    set begin = "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
    set temp = "%userprofile%\AppData\Local\Temp"
    set folder = %userprofile%\AppData\Local\Temp\Install
    set install = %userprofile%\AppData\Local\Temp\Install\Software
    set USB = %~d0
    set desk = %userprofile%\Desktop
    set anyconnect = %install%\anyconnect.msi
    set connectwise = %install%\Agent_Install.msi
    set duo = %install%\DuoDeviceHealth-2.26.0.msi
    set vnc = %install%\VNC.msi
    set splashtop = %install%\TemSplashtop_Business_Win_INSTALLER_v3.4.2.0.exe
    set firefox =  %install%\Firefox Installer.msi
    set dellcommand = %install%\dell_command.exe
    set bmc = %install%\Buchanan_Windows_Client_Install.exe
    set chrome = %install%\ChromeStandaloneSetup64.exe
    set office = %install%\OfficeSetup.exe
    set greenshot = %install%\Greenshot.exe
    set timechamp = %install%\silentservermode-setup-usr-stl-$$FQsLUlwGXVgeVwcOXRoHDAJUFEoKCQAUUgNWCRMGCUhMDR1WfnF9bXFrfnpzYw==.exe
REM Checks if computer has been rebooted and copies script into start
    if exist "%temp%\round3.txt" GOTO ROUND3
    if exist "%temp%\round2.txt" GOTO ROUND2
    if exist "%temp%\round1.txt" GOTO ROUND1
    xcopy "%folder%\BT Install.cmd" "%begin%\" /y /q
REM Main
    REM Temp file creation for restart check
        echo "R1">%temp%\round1.txt
        @echo off
    REM Copy files to %folder% for installation
    xcopy %USB%\Software "%folder%\" /y /q
    REM Moves to Install folder
        cd %install%\
    REM Install Splashtop
        start "" /wait msiexec.exe /i "%anyconnect%" /s /i
    REM Install ConnectWise
        start "" /wait msiexec.exe /i "%connectwise%" /quiet
    REM Install Firefox
        start "" /wait msiexec.exe /i "%firefox%" /quiet
    REM Install Google Chrome
        start "" /wait "%chrome%" /silent /install
    REM Install Dell Command Update
        start "" /wait "%dellcommand%" /s
    REM Install Duo Device Health
        start "" /wait msiexec.exe /i "%duo%" /quiet
    REM Install Buchanan Windows Client
        start "" /wait "%bmc%"
    REM Install Cisco Anyconnect
        start "" /wait msiexec.exe /i "%anyconnect%" /quiet
            REM Copy Profile for Cisco Anyconnect
                :L1
                SC queryex "%ServiceName%"|Find "STATE"|Find /v "RUNNING">Nul
                echo %ERRORLEVEL%
                if %ERRORLEVEL% EQU 0 GOTO L1
                    echo %ServiceName% is running
                @echo off
                timeout /T 1
    REM Install Greenshot

    REM Install VNC Viewer
        start "" /wait msiexec.exe /i "%vnc%" /quiet
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
        timeout /T 1
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