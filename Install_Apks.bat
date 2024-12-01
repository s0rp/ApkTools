@echo off
type x.conf
echo Loading...
echo Checking Obb 

set "obbp=%~dp0\obb"  

dir /ad "%obbp%" | findstr /i "." > nul
if %errorlevel% equ 0 (
    for /d %%i  in ("%obbp%\*") do (
        echo Installing Obb : %%~fi 
        echo Obb : %%~nxi
        "./Adb/adb.exe" push "%%~fi" "/sdcard/dcim/"
        "./Adb/adb.exe" shell mv "/sdcard/dcim/%%~nxi" "/sdcard/android/obb/%%~nxi"
    )
echo Finished Obb...
) else (
echo Cant Find Ant obb... Skipping.
)

SET mypath=%~dp0
for %%i in ("./apks/*") do (
    echo %mypath:~0,-1%\x\%%~nxi
    "./Adb/adb.exe" install "./apks/%%~i"
)
pause