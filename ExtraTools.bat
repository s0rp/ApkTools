@echo off
setlocal enabledelayedexpansion


:menu
set "secim="
set "port="
set "ip="
set "pairingcode="
set "dpi="
set "reresult="

cls

type x.conf
echo.
echo ApkTools Extras:
echo.
echo 1. See Abi
echo 2. Pair
echo 3. Connect
echo 4. Disconnect
echo 5. Screen
echo 6. Set Wm Density
echo 7. Cikis
echo.
set /p secim="Seciminizi girin: "

if "%secim%"=="1" goto see_abi
if "%secim%"=="2" goto pair
if "%secim%"=="3" goto connect
if "%secim%"=="4" goto disconnect
if "%secim%"=="5" goto screen
if "%secim%"=="6" goto set_wm_density
if "%secim%"=="7" goto exit

echo Gecersiz seçim. Lutfen tekrar deneyin.
pause
goto menu

:see_abi
for /f "delims=" %%a in ('"Adb\adb.exe" shell getprop ro.product.cpu.abi') do echo %%a
pause
goto menu

:pair
echo Cihaz IP'sini girin (IP:Port veya sadece IP)
set /p ip=

:: IP ve port'u kontrol et
echo %ip% | findstr /i /r "[0-9\.]*:[0-9]*" > nul
if errorlevel 1 (
  echo Baglanti noktasi girin
  set /p port=
  if "!port!"=="" (
    set port=5555
  )
  echo Girilen port: !port!
  set connectString=%ip%:!port!
) else (
  for /f "tokens=1,2 delims=:" %%a in ("%ip%") do (
    set ip=%%a
    set port=%%b
  )
  set connectString=%ip%%port%
)
echo Pairing Codeyi girin:
set /p pairingcode=
for /f "delims=" %%a in ('"Adb\adb.exe" pair %connectString% %pairingcode%') do echo %%a
pause
goto menu

:connect
echo Cihaz IP'sini girin (IP:Port veya sadece IP)
set /p ip=

:: IP ve port'u kontrol et
echo %ip% | findstr /i /r "[0-9\.]*:[0-9]*" > nul
if errorlevel 1 (
  echo Baglanti noktasi girin
  set /p port=
  if "!port!"=="" (
    set port=5555
  )
  echo Girilen port: !port!
  set connectString=%ip%:!port!
) else (
  for /f "tokens=1,2 delims=:" %%a in ("%ip%") do (
    set ip=%%a
    set port=%%b
  )
  set connectString=%ip%%port%
)

for /f "delims=" %%a in ('"Adb\adb.exe" connect %connectString%') do echo %%a
pause
goto menu

:disconnect
for /f "delims=" %%a in ('"Adb\adb.exe" disconnect') do echo %%a

pause
goto menu

:screen
for /f "delims=" %%a in ('"Scrcpy\scrcpy.exe"') do echo %%a

pause
goto menu

:set_wm_density
"./Adb/adb.exe" shell wm density

set /p dpi=Please write what DPI you want: 

"./Adb/adb.exe" shell wm density %dpi%

set /p reresult=Do you want to reboot? (Y/N)?

if /i "%reresult:~,1%" EQU "Y" "./Adb/adb.exe" reboot

echo Finished.
pause
goto menu

:exit
exit