$domain = "western-inventory.com"
$username = Read-Host -Prompt 'Please enter your username!' 
$password = Read-Host -Prompt 'Please enter your password!' | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -restart