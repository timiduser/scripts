# Run Script as Admin
    if (Test-Path -Path "$($env:TEMP)\start.txt") {
        Write-Output "Running as administrator!"
    }
    else {
        New-Item "$($env:TEMP)\start.txt" -Force
        Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
        Exit
    }
# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables for script
    $site = "https://www.dell.com/support/home/en-us"
    $active = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
    $CCN = HOSTNAME
    $fielPath = "${PSScriptRoot}\MuellerImage\Snaggit\RegInfo.txt"
    $vcRedistPath = "{your-path}\VC_redist.x64.exe"
    $params = "/uninstall /quiet /norestart"
    $choice = Read-Host -Prompt 'Please enter 1 for Laptop or 2 for Desktop'
# Functions to be called later on
function elivatedRun {
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    Exit
}
function clearWindow {
    Clear-Host
}

function cleanUp {
# Removing items installed by script. Need to move this to a scrip on its own and call after a system re-boot.
    elivatedRun
    Remove-Item -Force $env:PROGRAMFILES\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:TEMP\start.txt
    Uninstall-Module -Name DellBIOSProvider -Force
    Start-Process "${PSScriptRoot}\CDistro\VC_redist.x64.exe" -Wait -ArgumentList "/q /uninstall /norestart"
}
function compSetting {
    # Install Office
    # Install Splashtop
    # Install VNC

    
    # Set Activity Monitoring
    Write-Output "Setting up Activity Monitoring"
    Copy-Item -Path 'C:\Apps\Software\silentservermode-setup-usr-stl-$$FQsLUlwGXVgeVwcOXRoHDAJUFEoKCQAUUgNWCRMGCUhMDR1WfnF9bXFrfnpzYw==.exe' -Destination "C:\$active" -Force
    Clear-Host
    # Connectwise Install
    Write-Output "Installing Conectwise in the background"
    Start-Process -FilePath 'C:\Apps\Software\Agent_Install.msi' -ArgumentList /qn /quiet
    Clear-Host
    # Annyconnect Install
    Write-Output "Installing Anyconnect VPN"
    Start-Process  -FilePath 'C:\Apps\Software\anyconnect.msi' -ArgumentList /qn /quiet
    Clear-Host
    Write-Output "Setting VPN profile"
    Copy-Item -Path 'C:\Apps\Software\AnyConnectProfile.xsd' -Destination "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
    Clear-Host
    # BMC Install
    Write-Output "Installing BMC"
    Start-Process -FilePath 'C:\Apps\Software\Buchanan_Windows_Client_Install.exe'  -ArgumentList /silent /install
    Clear-Host
    # Google Chrome Install
    Write-Output "Installing Google Chrome"
    Start-Process 'C:\Apps\Software\ChromeStandaloneSetup64.exe'  -ArgumentList /silent /install
    Clear-Host
    # Dell Command Install
    Write-Output "Installing Dell Command"
    Start-Process 'C:\Apps\Software\dell_command.exe'  -ArgumentList /silent /install
    Clear-Host
    # Duo Health Install
    Write-Output "Installing Duo Health"
    Start-Process -FilePath 'C:\Apps\Software\DuoDeviceHealth.msi' -ArgumentList /qn /quiet
    Clear-Host
    # Firefox Install
    Write-Output "Installing Firefox"
    Start-Process 'C:\Apps\Software\Firefox Install.msi'  -ArgumentList /qn /quiet
    Clear-Host
    # Greenshot Install
    Write-Output "Installing Greenshot"
    Start-Process 'C:\Apps\Software\Greenshot.exe'  -ArgumentList /silent /install
    Clear-Host
}
function title {
    $host.UI.RawUI.WindowTitle = "$Title"
}
#Clears the screen from previous entries
    clearWindow
#Does the needed pre setup needed for Dell BIOS Provider to run and install properly
    $Title = 'Pre-Setup'
    title
    preSetup
# Gets, installs, and imports Dell BIOS Provider to use the commands needed
    $Title = 'Dell BIOS Setup'
    title
    bPSInstall
# Decision Making
    $Title = 'What type of Computer Setup?'
    title
    if ($choice -eq 1) {
        Clear-Host
        Write-Output 'Are you sure that you are wanting to run setup for a laptop?'
        $verifi = Read-Host -Prompt 'Y/N'
        if ($verifi -like 'Y' ) {
            $Title = 'Laptop Setup'
            title
            DellLaptop
            DellAll
            Write-Output 'Laptop BIOS settings have been changed, press enter to move onto computer settings.'
            Pause
        }
        elseif ($verifi -notlike "N") {
            Clear-Host
            Write-Output 'Invalid entry, closing window.'
            Remove-Item -Force $env:TEMP\start.txt
            Pause
            Exit
        }
        else {
            Clear-Host
            Write-Output 'Press enter to close'
            Remove-Item -Force $env:TEMP\start.txt
            Pause
            Exit
        }
    # Configuring customers settings
        clearWindow
        $Title = 'Computer Settings'
        title
        Write-Output "This is configuring the customers settings."
        compSetting
    # Cleans up what was installed and used.
        $Title = 'Script Cleanup'
        title    
        cleanUp
        Restart-Computer -Force
        Exit
    }
    elseif ($choice -eq 2) {
        Clear-Host
        Write-Output 'Are you sure that you are wanting to run setup for a desktop?'
        $verifi = Read-Host -Prompt 'Y/N'
        if ($verifi -like 'Y' ) {
            $Title = 'Desktop Setup'
            title
            DellDesktop
            DellAll
            Write-Output 'Desktop BIOS settings have been changed, press enter to move onto computer settings.'
            Pause
        }
        elseif ($verifi -notlike "N") {
            Clear-Host
            Write-Output 'Invalid entry, closing window.'
            Remove-Item -Force $env:TEMP\start.txt
            Pause
            Exit
        }
        else {
            Clear-Host
            Write-Output 'Press enter to close'
            Remove-Item -Force $env:TEMP\start.txt
            Pause
            Exit
        }
    # Configuring customers settings
        clearWindow
        $Title = 'Computer Settings'
        title
        Write-Output "This is configuring the customers settings."
        compSetting
    # Cleans up what was installed and used.
        $Title = 'Script Cleanup'
        title    
        cleanUp
        Restart-Computer -Force
        Exit
    }
    else {
        Write-Output "Not an available entry. Please select press enter or close out of this window."
        Pause
        Exit
    }
