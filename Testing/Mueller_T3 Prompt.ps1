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
    $pdata = 'ProgramData\TechSmith\Snagit 22'
    $CCN = HOSTNAME
    $fielPath = "${PSScriptRoot}\MuellerImage\Snaggit\RegInfo.txt"
    $vcRedistPath = "{your-path}\VC_redist.x64.exe"
    $params = "/uninstall /quiet /norestart"
    $choice = Read-Host -Prompt 'Please enter 1 for Laptop or 2 for Desktop'
# Functions to be called later on
function clearWindow {
    Clear-Host
}

function DellLaptop {
    $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).Attribute
    $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
    Set-Item Dellsmbios:\USBConfiguration\ThunderboltBoot Enabled
    $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltPreBoot).Attribute
    $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltPreBoot).CurrentValue
    Set-Item Dellsmbios:\USBConfiguration\ThunderboltPreBoot Enabled
    $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltPreBoot).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).Attribute
    $cvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
    Set-Item Dellsmbios:\Video\BrightnessBattery 9
    $nvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\LidSwitch Disabled
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnAc).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnAc).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\WakeOnAc Enabled
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnAc).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).Attribute
    $cvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
    Set-Item Dellsmbios:\POSTBehavior\FnLock Enabled
    $nvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\POSTBehavior\FnLockMode).Attribute
    $cvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLockMode).CurrentValue
    Set-Item Dellsmbios:\POSTBehavior\FnLockMode DisableStandard
    $nvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLockMode).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
}

function DellDesktop {
    $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    $avalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\AcPwrRcvry On
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
    Write-Output "· Changed $avalue settings from $cvalue to $nvalue" *>> $outloc

    $avalue = (Get-Item Dellsmbios:\PowerManagement\AutoOn).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\AutoOn).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\AutoOn EveryDay
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\AutoOn).CurrentValue
    Write-Output "· Changed $avalue settings from $cvalue to $nvalue" *>> $outloc

    $avalue = (Get-Item Dellsmbios:\PowerManagement\AutoOnHr).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\AutoOnHr).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\AutoOnHr 3
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\AutoOnHr).CurrentValue
    Write-Output "· Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
}

function DellAll {
    $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    $avalue = (Get-Item Dellsmbios:\PowerManagement\BlockSleep).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\BlockSleep).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\BlockSleep Enabled
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\BlockSleep).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc

    $avalue = (Get-Item Dellsmbios:\SystemConfiguration\EmbNic1).Attribute
    $cvalue = (Get-Item Dellsmbios:\SystemConfiguration\EmbNic1).CurrentValue
    Set-Item Dellsmbios:\SystemConfiguration\EmbNic1 Enabled
    $nvalue = (Get-Item Dellsmbios:\SystemConfiguration\EmbNic1).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).Attribute
    $cvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    Set-Item Dellsmbios:\SystemConfiguration\UefiNwStack Disabled
    $nvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnLan).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnLan).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\WakeOnLan LanOnly
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\WakeOnLan).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\Manageability\AmtCap).Attribute
    $cvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    Set-Item Dellsmbios:\Manageability\AmtCap Enabled
    $nvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).Attribute
    $cvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    Set-Item Dellsmbios:\Manageability\PostMebxKey Enabled
    $nvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue" *>> $outloc
    
    $avalue = (Get-Item Dellsmbios:\Security\AdminPassword).Attribute
    $cvalue = (Get-Item Dellsmbios:\Security\IsSystemPasswordSet).CurrentValue
    Set-Item Dellsmbios:\Security\AdminPassword 'Mu3eu$r2015'
    $nvalue = (Get-Item Dellsmbios:\Security\IsAdminPasswordSet).CurrentValue
    Write-Output "~ Changed $avalue settings from $cvalue to $nvalue." 'Password is Mu3eu$r2015' *>> $outloc
}
function preSetup{
# Dell BIOS PS Pre-Setup
    Start-Process "${PSScriptRoot}\CDistro\VC_redist.x64.exe" -Wait -ArgumentList "/q /norestart"
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    New-Item "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" -Force
}
function bPSInstall {
# Dell BIOS PS Install
    Clear-Host
    Write-Output "BIOS PS Install"
    Get-Module DellBIOSProvider
    Install-Module DellBIOSProvider -Confirm:$false
    Import-Module DellBIOSProvider
    Clear-Host
}
function cleanUp {
# Removing items installed by script. Need to move this to a scrip on its own and call after a system re-boot.
    Remove-Item -Force $env:PROGRAMFILES\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:TEMP\start.txt
    Uninstall-Module -Name DellBIOSProvider -Force
    Start-Process "${PSScriptRoot}\CDistro\VC_redist.x64.exe" -Wait -ArgumentList "/q /uninstall /norestart"
}
#Clears the screen from previous entries
    clearWindow
#Does the needed pre setup needed for Dell BIOS Provider to run and install properly
    preSetup
# Gets, installs, and imports Dell BIOS Provider to use the commands needed
    bPSInstall

# Decision Making
    if ($choice -eq 1) {
        Clear-Host
        Write-Output 'Are you sure that you are wanting to run setup for a laptop?'
        $verifi = Read-Host -Prompt 'Y/N'
        if ($verifi -like 'Y' ) {
            DellLaptop
            DellAll
            Pause
        }
        elseif ($verifi -notlike "N") {
            Clear-Host
            Write-Output 'Invalid entry, closing window.'
            Pause
            Exit
        }
        else {
            Clear-Host
            Write-Output 'Press enter to close'
            Pause
            Exit
        }
        Exit
    }
    elseif ($choice -eq 2) {
        Clear-Host
        Write-Output 'Are you sure that you are wanting to run setup for a desktop?'
        $verifi = Read-Host -Prompt 'Y/N'
        if ($verifi -like 'Y' ) {
            DellDesktop
            DellAll
            Pause
        }
        elseif ($verifi -notlike "N") {
            Clear-Host
            Write-Output 'Invalid entry, closing window.'
            Pause
            Exit
        }
        else {
            Clear-Host
            Write-Output 'Press enter to close'
            Pause
            Exit
        }
        Exit
    }
    else {
        Write-Output "Not an available entry. Please select press enter or close out of this window."
        Pause
        Exit
    }
# Configuring customers settings
    Write-Output "This is configuring the customers settings."
# Cleans up what was installed and used.
    cleanUp