# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables
    Set-Variable -Name "R1" -Value $null -Scope global -PassThru
    Set-Variable -Name "R2" -Value $null -Scope global -PassThru
    Set-Variable -Name "R3" -Value $null -Scope global -PassThru
    Set-Variable -Name "R4" -Value $null -Scope global -PassThru
    Set-Variable -Name "R5" -Value $null -Scope global -PassThru

# Winlogon Registry
function Start-WinLogonReg {

    Write-Output "Setting Winlogon Registry"
    Start-Process -FilePath 'C:\Drivers\Winlogonfixboot.reg' -Wait -ArgumentList /quiet
    Clear-Host
}
    
# Citrix Install
function Start-CitrixInstall {

    New-Item -Pat "$($env:TEMP)\" -Name Temp1.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Installing Citrix in the background"
    Start-Process -FilePath 'C:\Drivers\CitrixWorkspaceApp2112.exe' -ArgumentList /silent
    Set-Variable -Name R1 -Value "Citrix Install Completed" -Scope global -PassThru
    Clear-Host
}
    
# Logitech Install
function Start-LogitechInstall {

    New-Item -Path "$($env:TEMP)\" -Name Temp2.txt -Type "file" -Value "Logitech Installer"
    Write-Output "Installing Logitech Options in the background"
    Start-Process -FilePath 'C:\Drivers\Logitech SetPoint\options_9.50.269.exe' -Wait -ArgumentList /quiet
    Clear-Host
    Write-Output "Installing Logitech Setpoint in the background"
    Start-Process -FilePath 'C:\Drivers\Logitech SetPoint\SetPoint6.70.55_64.exe' -Wait -ArgumentList /s
    Set-Variable -Name R2 -Value "Logitech Install Completed" -Scope global -PassThru
    Clear-Host
}
    
# Snagit Activation
function Copy-Snagit {

    New-Item -Path "$($env:TEMP)\" -Name Temp3.txt -Type "file" -Value "Snagit Copy"
    Write-Output "Activating Snagit in the background"
    Copy-Item -Path \MuellerImage\Snaggit\RegInfo.ini -Destination "C:\ProgramData\TechSmith\Snagit 22" -Force
    Copy-Item -Path \MuellerImage\Snaggit\RegInfo.txt -Destination "C:\ProgramData\TechSmith\Snagit 22" -Force
    Set-Variable -Name R3 -Value "Snagit Activation Completed" -Scope global -PassThru
    Clear-Host
}
    
# Dell Support Assist
function Start-DellSupportAssist {
    param (
        $site = "https://www.dell.com/support/home/en-us"
    )
    New-Item -Path "$($env:TEMP)\" -Name Temp4.txt -Type "file" -Value "Dell Support Installer"    
    Write-Output "Installing Dell Support Assist in the background"
    Start-Process "\MuellerImage\Dell_Support\SupportAssistLauncher.exe" -Wait -ArgumentList -s
    Clear-Host
    Write-Output "Launching Dell Support Assist, please download driver updates then press Enter to continue!"
    Start-Process Chrome.exe $site
    Set-Variable -Name R4 -Value "Dell Support Assist Completed" -Scope global -PassThru
    Pause
}
    
# Disable Hibrenate
function Update-Hibernate {

    New-Item -Path "$($env:TEMP)\" -Name Temp5.txt -Type "file" -Value "Citrix Installer"
    Write-Output "Disabling Hibernate"
    powercfg.exe -h off
    Clear-Host
}
    
# Computer Naming
function Update-ComputerName {
    $MyName =Read-Host -Prompt 'Input New Computer Name '
    Write-Output Changing computer name from: $env:COMPUTERNAME  to new computer name: $MyName
    Rename-Computer -ComputerName $CCN -NewName $MyName
    Write-Output "Automated section has completed! Please press Enter to close the script."
    Set-Variable -Name R5 -Value "Computer Name Completed" -Scope global -PassThru
}

# Computer restart and cleanup
function Start-Clean {

    Remove-Item -Path "$($env:TEMP)\Temp1.txt" -Force
    Remove-Item -Path "$($env:TEMP)\Temp2.txt" -Force
    Remove-Item -Path "$($env:TEMP)\Temp3.txt" -Force
    Remove-Item -Path "$($env:TEMP)\Temp4.txt" -Force
    Remove-Item -Path "$($env:TEMP)\Temp5.txt" -Force
    Restart-Computer -Force
}

# Start of script
if (-Not (Get-Item -Path "$($env:TEMP)\Temp1.txt" -ErrorAction Ignore)) {
    Write-Output "First run of Installation"
    Start-WinLogonReg
    Start-CitrixInstall
    Start-LogitechInstall
    Copy-Snagit
    Start-DellSupportAssist
    Update-Hibernate
    Update-ComputerName
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    Start-Clean
}
elseif (-Not (Get-Item -Path "$($env:TEMP)\Temp2.txt" -ErrorAction Ignore)) {
    Write-Output "Second run of Installation"
    Start-LogitechInstall
    Copy-Snagit
    Start-DellSupportAssist
    Update-Hibernate
    Update-ComputerName
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    Start-Clean
}
elseif (-Not (Get-Item -Path "$($env:TEMP)\Temp3.txt" -ErrorAction Ignore)) {
    Write-Output "Third run of Installation"
    Copy-Snagit
    Start-DellSupportAssist
    Update-Hibernate
    Update-ComputerName
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    Start-Clean
}
elseif (-Not (Get-Item -Path "$($env:TEMP)\Temp4.txt" -ErrorAction Ignore)) {
    Write-Output "Fourth run of Installation"
    Start-DellSupportAssist
    Update-Hibernate
    Update-ComputerName
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    Start-Clean
}
elseif (-Not (Get-Item -Path "$($env:TEMP)\Temp5.txt" -ErrorAction Ignore)) {
    Write-Output "Fifth run of Installation"
    Update-Hibernate
    Update-ComputerName
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    Start-Clean
}
else {
    Write-Output "Went through all steps"
    Write-Output "R1"
    Write-Output "R2"
    Write-Output "R3"
    Write-Output "R4"
    Write-Output "R5"
    Pause
    End
}



    