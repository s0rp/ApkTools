@echo off
type x.conf


"./Adb/adb.exe" shell wm density

set /p input=Please write what DPI you want: 

"./Adb/adb.exe" shell wm density %input%

set /p result=Do you want to reboot? (Y/N)?

if /i "%result:~,1%" EQU "Y" "./Adb/adb.exe" reboot

echo Finished.

pause