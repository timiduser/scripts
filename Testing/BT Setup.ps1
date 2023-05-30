# Starts the script as Admin
        Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables for script
    $active = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
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
    # Set Activity Monitoring
    Write-Output "Setting up Activity Monitoring"
    Copy-Item -Path 'C:\Apps\Software\silentservermode-setup-usr-stl-$$FQsLUlwGXVgeVwcOXRoHDAJUFEoKCQAUUgNWCRMGCUhMDR1WfnF9bXFrfnpzYw==.exe' -Destination "C:\$active" -Force
    Clear-Host
    # Install SoftPhone
    Write-Output "Installing Mitel Soft phone"
    Start-Process -FilePath 'C:\Apps\Software\MicoLab\softphone.msi' -ArgumentList /qn UC_SERVER_HOSTNAME=c1vmas.buchanan.com UC_LANGUAGE=en
    Clear-Host
    # Annyconnect Install
    Write-Output "Installing Anyconnect VPN"
    Start-Process  -FilePath 'C:\Apps\Software\anyconnect.msi' -ArgumentList /qn /quiet -Wait
    Clear-Host
    Write-Output "Setting VPN profile"
    Copy-Item -Path 'C:\Apps\Software\AnyConnectProfile.xsd' -Destination "C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\"
    Clear-Host
    # BMC Install
    Write-Output "Installing BMC"
    Start-Process -FilePath 'C:\Apps\Software\BMC.exe'  -ArgumentList /silent /install -Wait
    Clear-Host
    # Google Chrome Install
    Write-Output "Installing Google Chrome"
    Start-Process 'C:\Apps\Software\ChromeStandaloneSetup64.exe'  -ArgumentList /silent /install -Wait
    Clear-Host
    # Dell Command Install
    Write-Output "Installing Dell Command"
    Start-Process 'C:\Apps\Software\dell_command.exe'  -ArgumentList /silent /install -Wait
    Clear-Host
    # Duo Health Install
    Write-Output "Installing Duo Health"
    Start-Process -FilePath 'C:\Apps\Software\Duo.msi' -ArgumentList /qn /quiet -Wait
    Clear-Host
    # Firefox Install
    Write-Output "Installing Firefox"
    Start-Process 'C:\Apps\Software\Firefox Install.msi'  -ArgumentList /qn /quiet -Wait
    Clear-Host
    # Greenshot Install
    Write-Output "Installing Greenshot"
    Start-Process 'C:\Apps\Software\Greenshot.exe'  -ArgumentList /silent /install -Wait
    Clear-Host
    # Install Office
    Write-Output "Installing Office 365"
    Start-Process 'C:\Apps\Software\Office\Greenshot.exe'  /configure configuration-Office365-x64.xml -Wait
    # Install VNC
    Write-Output "Installing VNC Viewer"
    Start-Process 'C:\Apps\Software\Office\VNC.msi'  -ArgumentList /qn /quiet -Wait
    # Install Splashtop
    Write-Output "Installing Splashtop"
    Start-Process 'C:\Apps\Software\Office\Splashtop.msi'  -ArgumentList /qn /quiet -Wait
}
function title {
    $host.UI.RawUI.WindowTitle = "$Title"
}
# Clears the screen from previous entries
    clearWindow
# Main Code
compSetting
Restart-Computer