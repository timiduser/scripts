Get-AppXPackage -AllUsers -Name microsoft.windowscommunicationsapps | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WindowsCamera | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.DesktopAppInstaller | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.Windows.Photos | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WindowsStore | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.GetHelp | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.Getstarted | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.MicrosoftStickyNotes | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.MSPaint | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.ScreenSketch | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.StorePurchaseApp | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.Wallet | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WebMediaExtensions | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WindowsCalculator | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WindowsFeedbackHub | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}
Start-Sleep -Seconds 3
Get-AppXPackage -AllUsers -Name Microsoft.WindowsSoundRecorder | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -Verbose}