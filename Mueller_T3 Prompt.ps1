# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Clear Window
    Clear-Host
# Variables for script
    $site = "https://www.dell.com/support/home/en-us"
    $pdata = 'ProgramData\TechSmith\Snagit 22'
    $CCN = HOSTNAME
    $fielPath = "\MuellerImage\Snaggit\RegInfo.txt"
    $choice = Read-Host -Prompt 'Please enter 1 for Laptop or 2 for Desktop'

# Functions to be called later on
    function DellLaptop {
        $outval = "· Changed $avalue settings from $cvalue to $nvalue"
        $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

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

        $avalue = (Dellsmbios:\Video\BrightnessBattery).Attribute
        $cvalue = (Dellsmbios:\Video\BrightnessBattery).CurrentValue
        Set-Item Dellsmbios:\Video\BrightnessBattery 9
        $nvalue = (Dellsmbios:\Video\BrightnessBattery).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\PowerManagement\LidSwitch).Attribute
        $cvalue = (Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
        Set-Item Dellsmbios:\PowerManagement\LidSwitch Disabled
        $nvalue = (Dellsmbios:\PowerManagement\LidSwitch).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).Attribute
        $cvalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
        Get-Item Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc
        Set-Item Dellsmbios:\PowerManagement\WakeOnAc Enabled
        $nvalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnAc).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\POSTBehavior\FnLock).Attribute
        $cvalue = (Dellsmbios:\POSTBehavior\FnLock).CurrentValue
        Set-Item Dellsmbios:\POSTBehavior\FnLock Enabled
        $nvalue = (Dellsmbios:\POSTBehavior\FnLock).CurrentValue
        Write-Output $outval *>> $outloc

    }
    function DellDesktop {
        $outval = "· Changed $avalue settings from $cvalue to $nvalue"
        $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

        $avalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).Attribute
        $cvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
        Set-Item Dellsmbios:\PowerManagement\AcPwrRcvry On
        $nvalue = (Get-Item Dellsmbios:\PowerManagement\AcPwrRcvry).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).Attribute
        $cvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).CurrentValue
        Set-Item Dellsmbios:\PowerManagement\AutoOn EveryDay
        $nvalue = (Get-Item Dellsmbios:\PowerManagement\PowerManagement\AutoOn).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).Attribute
        $cvalue = (Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).CurrentValue
        Set-Item Dellsmbios:\PowerManagement\AutoOnHr 3
        $nvalue = (Dellsmbios:\PowerManagement\PowerManagement\AutoOnHr).CurrentValue
        Write-Output $outval *>> $outloc
    }
    function DellAll {
        $outval = "· Changed $avalue settings from $cvalue to $nvalue"
        $outloc = "$($env:USERPROFILE)\Desktop\BIOS Settings.txt"

    #    Set-Item Dellsmbios:\PowerManagement\AcPwrRcvry "Mu3eu$r2015" *>> "$($env:USERPROFILE)\Desktop\BIOS Settings.txt" Needs to be tested manually before rolling out!!!!!

        $avalue = (Dellsmbios:\SystemConfiguration\UefiNwStack).Attribute
        $cvalue = (Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
        Set-Item Dellsmbios:\SystemConfiguration\UefiNwStack Disabled
        $nvalue = (Dellsmbios:\SystemConfiguration\UefiNwStack).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).Attribute
        $cvalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
        Set-Item Dellsmbios:\PowerManagement\WakeOnLan LanOnly
        $nvalue = (Dellsmbios:\PowerManagement\PowerManagement\WakeOnLan).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\Manageability\AmtCap).Attribute
        $cvalue = (Dellsmbios:\Manageability\AmtCap).CurrentValue
        Set-Item Dellsmbios:\Manageability\AmtCap Enabled
        $nvalue = (Dellsmbios:\Manageability\AmtCap).CurrentValue
        Write-Output $outval *>> $outloc

        $avalue = (Dellsmbios:\Manageability\PostMebxKey).Attribute
        $cvalue = (Dellsmbios:\Manageability\PostMebxKey).CurrentValue
        Set-Item Dellsmbios:\Manageability\PostMebxKey Enabled
        $nvalue = (Dellsmbios:\Manageability\PostMebxKey).CurrentValue
        Write-Output $outval *>> $outloc

    }

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