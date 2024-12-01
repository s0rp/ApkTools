@echo off
type x.conf
echo Loading...
echo Checking Obb 
SET mypath=%~dp0
set "obbp=%~dp0\obb"  
set "AtDir=%mypath%\AT\ApkTools.exe"  

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
for %%a in ("./xapks/*.xapk") do (
  echo Unzipping %%~nxa...
  if exist "%mypath:~0,-1%\xapks\%%~na" RMDIR /S /Q %mypath:~0,-1%\xapks\%%~na 
  "C:\Program Files\7-Zip\7z.exe" x "%mypath:~0,-1%\xapks\%%~nxa" -o"%mypath:~0,-1%\xapks\%%~na"
)
for /d %%i  in ("./xapks/*") do (
  echo Xapk : %%~nxi 
  echo Preparing For Installation %%~nxi...
  echo %AtDir%
  for /f "delims=" %%a in ('%AtDir% -b "%mypath:~0,-1%\xapks\%%~nxi"') do (
    echo Installing %%~nxi...
   "./Adb/adb.exe" install-multiple %%a
    echo Installed %%~nxi...
    if exist "%mypath:~0,-1%\xapks\%%~nxi" RMDIR /S /Q %mypath:~0,-1%\xapks\%%~nxi
  )
)
pause


