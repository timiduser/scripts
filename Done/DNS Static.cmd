REM "This file sets DNS to a static IP"
echo off
title "Setting DNS to 192.168.211.109"
echo "Setting DNS to 192.168.211.109"
netsh interface ip set dns "Wi-Fi" static 192.168.211.109
