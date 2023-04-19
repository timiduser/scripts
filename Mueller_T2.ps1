# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables for script
    $site = "https://www.dell.com/support/home/en-us"
    $pdata = 'ProgramData\TechSmith\Snagit 22'
    $CCN = HOSTNAME
    $fielPath = "\MuellerImage\Snaggit\RegInfo.txt"
# Winlogon Registry
    Write-Output "Setting Winlogon Registry"
    Start-Process -FilePath 'C:\Drivers\Winlogonfixboot.reg' -Wait -ArgumentList /quiet
    Clear-Host
# Citrix Install
    New-Item -Pat "$($env:TEMP)\" -Name Temp1.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Installing Citrix in the background"
    Start-Process -FilePath 'C:\Drivers\CitrixWorkspaceApp2112.exe' -ArgumentList /silent
    Clear-Host
# Logitech Install
    New-Item -Path "$($env:TEMP)\" -Name Temp2.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Installing Logitech Options in the background"
    Start-Process -FilePath 'C:\Drivers\Logitech SetPoint\options_9.50.269.exe' -Wait -ArgumentList /quiet
    Clear-Host
    Write-Output "Installing Logitech Setpoint in the background"
    Start-Process -FilePath 'C:\Drivers\Logitech SetPoint\SetPoint6.70.55_64.exe' -Wait -ArgumentList /s
    Clear-Host
# Snagit Activation
    New-Item -Path "$($env:TEMP)\" -Name Temp3.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Activating Snagit in the background"
    Copy-Item -Path \MuellerImage\Snaggit\RegInfo.ini -Destination "C:\$pdata" -Force
    Copy-Item -Path \MuellerImage\Snaggit\RegInfo.txt -Destination "C:\$pdata" -Force
    Clear-Host
    while (!(Test-Path $fielPath)) {
    Write-Host "Waiting for file to exist..."
    Start-Sleep -Seconds 1    
    }
    Write-Host "File exists. Continuing script execution..."
# Dell Support Assist
    New-Item -Path "$($env:TEMP)\" -Name Temp4.txt -Type "file" -Value "Citrix Installer"    
    Write-Output "Installing Dell Support Assist in the background"
    Start-Process "\MuellerImage\Dell_Support\SupportAssistLauncher.exe" -Wait -ArgumentList -s
    Clear-Host
    Write-Output "Launching Dell Support Assist, please download driver updates then press Enter to continue!"
    Start-Process Chrome.exe $site
    Pause
# Disable Hibrenate
    New-Item -Path "$($env:TEMP)\" -Name Temp5.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Disabling Hibernate"
    powercfg.exe -h off
    Clear-Host
# Computer Naming
    $MyName =Read-Host -Prompt 'Input New Computer Name '
    Write-Output Changing computer name from: $CCN to new computer name: $MyName
    Rename-Computer -ComputerName $CCN -NewName $MyName
    Write-Output "Automated section has completed! Please press Enter to close the script."
    Restart-Computer -Force
    Pause