@echo off
set VAR=Destination
for /f "skip=1" %%L in ('wmic logicaldisk where volumename^="IA_DYNAMIC_DATA" Get Caption') do @call :SetVar %%L

echo Copying data to %Destination%
pause
goto :EOF

:SetVar
set Label=%1
if NOT [%Label%]==[] set %VAR%=%Label%
goto :EOF