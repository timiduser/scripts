@echo off
color 0A
REM Local variables
set WIN=WIS_WIN10_ENT_20221007_Base.wim
set VAR=Destination
:Start
for /f "skip=1" %%L in ('wmic logicaldisk where volumename^="IA_DYNAMIC_DATA" Get Caption') do @call :SetVar %%L
echo "Copy/Overwrite all files?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" EQU "Y" GOTO O1
cls            
echo "Copy over specific file/s?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" EQU "Y" GOTO S1
cls
echo "Why did you run me then?"
@echo off
timeout /t 10 > nul 
exit
REM Overwrite all files on flash drive
:O1
    cls
    xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee12mlk3_a14.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
    xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee13tgl_a11.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
    xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee13tgl5520_a15.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
    xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee14mlk_a02.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
    xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\IMG\%WIN%" "%Destination%\Dell_Images\" /y /i
:L2
    echo "Did files copy over?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" NEQ "Y" GOTO L2
    echo "Would you like do another USB?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" NEQ "Y" GOTO EXT
        timeout /t 10
        GOTO Start
REM Copy over specific files onto flash drive
:S1
    cls
    echo "Do you want to copy drivers?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" EQU "Y" GOTO Driver
    cls
    echo "Did you want to copy the image?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" EQU "Y" GOTO Image
                exit

    :Driver
        xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee12mlk3_a14.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
        xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee13tgl_a11.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
        xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee13tgl5520_a15.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
        xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\Driver Packs\win10_latitudee14mlk_a02.zip" "%Destination%\Dell_Driver_Packs_Local\" /y /i
        GOTO L3
    :Image
        xcopy "C:\Users\tschoneman\OneDrive - Buchanan Technologies Ltd\Desktop\CMK Image\IMG\%WIN%" "%Destination%\Dell_Images\" /y /i
        GOTO L3
:L3
    echo "Did files copy over?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" NEQ "Y" GOTO L3
    echo "Would you like do another USB?"
        SET /P AREYOUSURE=Are you sure (Y/[N])?
            if /I "%AREYOUSURE%" NEQ "Y" GOTO EXT
        timeout /t 10
        GOTO Start
:EXT
    exit

:SetVar
    set Label=%1
    if NOT [%Label%]==[] set %VAR%=%Label%
        goto :EOF