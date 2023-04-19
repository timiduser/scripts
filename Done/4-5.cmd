REM Variables for script(change site domain per project)
	set site=adprfj1.sonic.com
REM Runs Connectwise Installer
	start %~d0\SP\"4 - Agent_Install.exe"
REM Goes to CDK installer
	start iexplore.exe http://%site%/apps/autoTools/sda/download/installers/WSPCP/
