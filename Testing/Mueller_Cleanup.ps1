function elivatedRun {
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    Exit
}
function cleanUp {
# Removing items installed by script. Need to move this to a scrip on its own and call after a system re-boot.
    Remove-Item -Force $env:PROGRAMFILES\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:LOCALAPPDATA\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll
    Remove-Item -Force $env:TEMP\start.txt
    Uninstall-Module -Name DellBIOSProvider -Force
    Start-Process "${PSScriptRoot}\CDistro\VC_redist.x64.exe" -Wait -ArgumentList "/q /uninstall /norestart"
}
Set-ExecutionPolicy RemoteSigned
cleanUp
shutdown.exe /r /t 0