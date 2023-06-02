# Starts the script as Admin
Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
# Allow Powershell Scripts to run
Set-ExecutionPolicy RemoteSigned
# Domain join
$domain = "buchanan.com"
$password = "The program gave an error of 2023" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\ts_admin" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -restart