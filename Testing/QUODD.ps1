# Allow Powershell Scripts to run
Set-ExecutionPolicy RemoteSigned
# Variables for script
    $site = "https://www.dell.com/support/home/en-us"
    $pdata = 'ProgramData\TechSmith\Snagit 22'
    $CCN = HOSTNAME
    $fielPath = "\MuellerImage\Snaggit\RegInfo.txt"
    $password = +qfAMVu(Ngr@ | ConvertTo-SecureString -asPlainText -Force
function title {
    $host.UI.RawUI.WindowTitle = "$Title"
    }
function elivatedRun {
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    Exit
}
function ladmin {
    New-LocalUser -Name 'QuoddAdmin' -Description 'QUODD local admin accoutn' -Password "$password" -PasswordNeverExpires
    }
function endUser {
    $uname = Read-Host -Prompt 'Please enter this users username. Ex(firstnamelastame)'
    $pword = ""
    New-LocalUser -Name "$uname" -Password "$" -PasswordNeverExpires
}