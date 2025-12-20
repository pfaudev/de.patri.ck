@ECHO off
CALL D:\SOFTWARE\PortableApps\CommonFiles\Tools\fpcalc.exe %%1 > %TEMP%\fp.txt
START %TEMP%\fp.txt
PAUSE
DEL /Q %TEMP%\fp.txt
EXIT