$domain = "buchanan.com"
$password = "The program gave an error of 2023" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\ts_admin" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Remove-Computer -UnjoinDomainCredential $credential -WorkgroupName "WORKGROUP" -Restart -Force