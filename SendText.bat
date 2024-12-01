@echo off
type x.conf

:re

set /p input=Please give text : 


"./Adb/adb.exe" shell input text "%input%"

echo Ok.

goto re
