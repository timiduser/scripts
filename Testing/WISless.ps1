# Starts the script as Admin
        Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
# Allow Powershell Scripts to run
    Set-ExecutionPolicy RemoteSigned
# Variables for script
    $active = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp'
    $choice = Read-Host -Prompt 'Please enter 1 for Laptop or 2 for Desktop'
# Run the script as admin
function elivatedRun {
    Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
    Exit
}
# Clears the console window
function clearWindow {
    Clear-Host
}
# Removing items installed by script. Need to move this to a scrip on its own and call after a system re-boot.
function cleanUp {
    
    elivatedRun
}
# Sets the tile of the console
function title {
    $host.UI.RawUI.WindowTitle = "$Title"
}
# Clears the screen from previous entries
    clearWindow
# Main Code
