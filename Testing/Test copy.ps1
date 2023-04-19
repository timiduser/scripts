function Update-ComputerName {
  $MyName =Read-Host -Prompt 'Input New Computer Name '
  Write-Output Changing computer name from: $env:COMPUTERNAME to new computer name: $MyName
  Write-Output "Automated section has completed! Please press Enter to close the script."
  Set-Variable -Name R5 -Value "Computer Name Completed" -Scope global -PassThru
}

Update-ComputerName