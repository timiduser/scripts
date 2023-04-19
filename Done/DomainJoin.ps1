$domain = "sonic.com"
$password = "Child Branch Rock Comb Oil(" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\tyler.schoneman" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -restart