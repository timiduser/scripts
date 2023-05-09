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
# Clear Window
    Clear-Host
# Variables for script
    # $site = "https://www.dell.com/support/home/en-us"
    # $pdata = 'ProgramData\TechSmith\Snagit 22'
    # $CCN = HOSTNAME
    # $fielPath = "${PSScriptRoot}\MuellerImage\Snaggit\RegInfo.txt"
    # $vcRedistPath = "{your-path}\VC_redist.x64.exe"
    # $params = "/uninstall /quiet /norestart"
    # $choice = Read-Host -Prompt 'Please enter 1 for Laptop or 2 for Desktop'
    # Below are test variables to be used in functions later
    $outval = "· Changed $avalue settings from $cvalue to $nvalue"
    $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
# Dell BIOS PS Pre-Setup
    Clear-Host
    Start-Process "${PSScriptRoot}\MuellerImage\CDistro\VC_redist.x64.exe" -Wait -ArgumentList -s
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    New-Item "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" -Force
# Dell BIOS PS Install
    Clear-Host
    Write-Output "BIOS PS Install"
    Get-Module DellBIOSProvider
    Install-Module DellBIOSProvider -Confirm:$false
    Import-Module DellBIOSProvider
    Clear-Host
# Test for verfication
    $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).Attribute
    $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
    Set-Item Dellsmbios:\USBConfiguration\ThunderboltBoot Enabled
    $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).Attribute
    $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).CurrentValue
    Set-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot Enabled
    $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).Attribute
    $cvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
    Set-Item Dellsmbios:\Video\BrightnessBattery 9
    $nvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\LidSwitch Disabled
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
    Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc
    Set-Item Dellsmbios:\PowerManagement\WakeOnAc Enabled
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).Attribute
    $cvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
    Set-Item Dellsmbios:\POSTBehavior\FnLock Enabled
    $nvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).Attribute
    $cvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    Set-Item Dellsmbios:\SystemConfiguration\UefiNwStack Disabled
    $nvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).Attribute
    $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
    Set-Item Dellsmbios:\PowerManagement\WakeOnLan LanOnly
    $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\Manageability\AmtCap).Attribute
    $cvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    Set-Item Dellsmbios:\Manageability\AmtCap Enabled
    $nvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    Write-Output $outval *>> $outloc

    $avalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).Attribute
    $cvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    Set-Item Dellsmbios:\Manageability\PostMebxKey Enabled
    $nvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    Write-Output $outval *>> $outloc
# # Functions to be called later on
#     function DellLaptop {
#         $outval = "· Changed $avalue settings from $cvalue to $nvalue"
#         $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

#         $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).Attribute
#         $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
#         Set-Item Dellsmbios:\USBConfiguration\ThunderboltBoot Enabled
#         $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot).CurrentValue
#         Write-Output $outval *>> $outloc

#         $avalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).Attribute
#         $cvalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).CurrentValue
#         Set-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot Enabled
#         $nvalue = (Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot).CurrentValue
#         Write-Output $outval *>> $outloc

#         $avalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).Attribute
#         $cvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
#         Set-Item Dellsmbios:\Video\BrightnessBattery 9
#         $nvalue = (Get-Item Dellsmbios:\Video\BrightnessBattery).CurrentValue
#         Write-Output $outval *>> $outloc

#         $avalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).Attribute
#         $cvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
#         Set-Item Dellsmbios:\PowerManagement\LidSwitch Disabled
#         $nvalue = (Get-Item Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
#         Write-Output $outval *>> $outloc

#         $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).Attribute
#         $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
#         Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc
#         Set-Item Dellsmbios:\PowerManagement\WakeOnAc Enabled
#         $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
#         Write-Output $outval *>> $outloc

#         $avalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).Attribute
#         $cvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
#         Set-Item Dellsmbios:\POSTBehavior\FnLock Enabled
#         $nvalue = (Get-Item Dellsmbios:\POSTBehavior\FnLock).CurrentValue
#         Write-Output $outval *>> $outloc

#     }
    # function DellDesktop {
    #     $outval = "· Changed $avalue settings from $cvalue to $nvalue"
    #     $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    #     $avalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
    #     Set-Item Dellsmbios:\PowerManagement\AcPwrRcvry On
    #     $nvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
    #     Write-Output $outval *>> $outloc

    #     $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).CurrentValue
    #     Set-Item Dellsmbios:\PowerManagement\AutoOn EveryDay
    #     $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).CurrentValue
    #     Write-Output $outval *>> $outloc

    #     $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).CurrentValue
    #     Set-Item Dellsmbios:\PowerManagement\AutoOnHr 3
    #     $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).CurrentValue
    #     Write-Output $outval *>> $outloc
    # }
    # function DellAll {
    #     $outval = "· Changed $avalue settings from $cvalue to $nvalue"
    #     $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    # #   Set-Item Dellsmbios:\Security\AdminPassword "Mu3eu$r2015" *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" Needs to be tested manually before rolling out!!!!!

    #     $avalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    #     Set-Item Dellsmbios:\SystemConfiguration\UefiNwStack Disabled
    #     $nvalue = (Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
    #     Write-Output $outval *>> $outloc

    #     $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
    #     Set-Item Dellsmbios:\PowerManagement\WakeOnLan LanOnly
    #     $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
    #     Write-Output $outval *>> $outloc

    #     $avalue = (Get-Item Dellsmbios:\Manageability\AmtCap).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    #     Set-Item Dellsmbios:\Manageability\AmtCap Enabled
    #     $nvalue = (Get-Item Dellsmbios:\Manageability\AmtCap).CurrentValue
    #     Write-Output $outval *>> $outloc

    #     $avalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).Attribute
    #     $cvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    #     Set-Item Dellsmbios:\Manageability\PostMebxKey Enabled
    #     $nvalue = (Get-Item Dellsmbios:\Manageability\PostMebxKey).CurrentValue
    #     Write-Output $outval *>> $outloc

    # }

# Decision Making
#     if ($choice -eq 1) {
#         Clear-Host
#         Write-Output 'Are you sure that you are wanting to run setup for a laptop?'
#         $verifi = Read-Host -Prompt 'Y/N'
#         if ($verifi -like 'Y' ) {
#             DellLaptop
#             DellAll
#             Pause
#         }
#         elseif ($verifi -notlike "N") {
#             Clear-Host
#             Write-Output 'Invalid entry, closing window.'
#             Pause
#             Exit
#         }
#         else {
#             Clear-Host
#             Write-Output 'Press enter to close'
#             Pause
#             Exit
#         }
#         Exit
#     }
#     elseif ($choice -eq 2) {
#         Clear-Host
#         Write-Output 'Are you sure that you are wanting to run setup for a desktop?'
#         $verifi = Read-Host -Prompt 'Y/N'
#         if ($verifi -like 'Y' ) {
#             DellDesktop
#             DellAll
#             Pause
#         }
#         elseif ($verifi -notlike "N") {
#             Clear-Host
#             Write-Output 'Invalid entry, closing window.'
#             Pause
#             Exit
#         }
#         else {
#             Clear-Host
#             Write-Output 'Press enter to close'
#             Pause
#             Exit
#         }
#         Exit
#     }
#     else {
#         Write-Output "Not an available entry. Please select press enter or close out of this window."
#         Pause
#         Exit
#     }
# # Configuring customers settings
#     Write-Output "This is configuring the customers settings."
# # Removing items installed by script. Need to move this to a scrip on its own and call after a system re-boot.
#     Remove-Item -Force $env:ProgramFiles\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
#     Uninstall-Module -Name DellBIOSProvider -Force -Scope CurrentUser
#     Start-Process -FilePath $vcRedistPath -ArgumentList $params -Wait