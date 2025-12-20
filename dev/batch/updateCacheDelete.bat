@ECHO OFF
CHCP 1252
TITLE patri.ck ^| WindowsUpdateCacheLeeren v2020
CLS

del /F /S /Q "C:\Windows\SoftwareDistribution\*"

PAUSE
EXIT 