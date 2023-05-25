# Allow Powershell Scripts to run
Set-ExecutionPolicy RemoteSigned
# All Functions to be called on
function domainJoin {
    $domain = "buchanan.com"
    $password = "The program gave an error of 2023" | ConvertTo-SecureString -asPlainText -Force
    $username = "$domain\ts_admin"
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)
    Add-Computer -DomainName $domain -Credential $credential
}

function re-name {
    $SerialNumber = (Get-WmiObject -class win32_bios).SerialNumber  
    $computer = "REMSDC-$SerialNumber"  
    Rename-Computer -NewName $computer -Force  
}

function connectwise {
    Start-Process "C:\Apps\Software\Agent_Install.MSI" -Wait -ArgumentList "/q /norestart"
    
}

#Main code
    re-name
    connectwise
    domainJoin