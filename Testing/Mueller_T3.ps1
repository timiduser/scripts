# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables for script
    $site = "https://www.dell.com/support/home/en-us"
    $pdata = 'ProgramData\TechSmith\Snagit 22'
    $CCN = HOSTNAME
    $fielPath = "\MuellerImage\Snaggit\RegInfo.txt"
# Dell BIOS PS Pre-Setup
    Start-Process "\MuellerImage\CDistro\VC_redist.x64.exe" -Wait -ArgumentList -s
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    New-Item "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
# Dell BIOS PS Install
    Get-Module DellBIOSProvider
    Install-Module DellBIOSProvider -Confirm:$false
# Dell BIOS Settings
    Import-Module DellBIOSProvider
    Get-Item Dellsmbios:\USBConfiguration\ThunderboltBoot *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\USBConfiguration\ThunderboltBoot Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\USBConfiguration\ThurnderboltPreBoot Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\Video\BrightnessBattery *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\Video\BrightnessBattery 9 *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\SystemConfiguration\UefiNwStack *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Set-Item Dellsmbios:\SystemConfiguration\UefiNwStack Disabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Get-Item Dellsmbios:\PowerManagement\LidSwitch *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\PowerManagement\LidSwitch Disabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
    Set-Item Dellsmbios:\PowerManagement\AcPwrRcvry On *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
#    Set-Item Dellsmbios:\Security\AdminPassword "Mu3eu$r2015" *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" Needs to be tested manually before rolling out!!!!!
    Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\PowerManagement\WakeOnAc Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" 
    Set-Item Dellsmbios:\PowerManagement\WakeOnLan LanOnly *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
    Set-Item Dellsmbios:\PowerManagement\AutoOn EveryDay *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
    Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
    Set-Item Dellsmbios:\PowerManagement\AutoOnHr 3 *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Desktop Only
    Get-Item Dellsmbios:\Manageability\AmtCap *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Set-Item Dellsmbios:\Manageability\AmtCap Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Get-Item Dellsmbios:\Manageability\PostMebxKey *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Set-Item Dellsmbios:\Manageability\PostMebxKey Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"
    Get-Item Dellsmbios:\POSTBehavior\FnLock *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\POSTBehavior\FnLock Enabled *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Get-Item Dellsmbios:\POSTBehavior\FnLockMode *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only
    Set-Item Dellsmbios:\POSTBehavior\FnLockMode DisableStandard *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" #Laptop Only