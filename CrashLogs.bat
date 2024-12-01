@echo off
type x.conf

:re

"./Adb/adb.exe" shell logcat -b crash

goto re
