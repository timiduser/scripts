$domain = "crossmark.internal.pvt"
$password = 'Z$x9f26!' | ConvertTo-SecureString -asPlainText -Force
$username = "Dalpapp_dell" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -restart