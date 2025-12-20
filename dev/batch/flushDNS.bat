@ECHO OFF
CHCP 1252
TITLE \\patri.ck\\flushDNS\\2020
CLS
SET L= 
ECHO.
ipconfig /flushdns
PAUSE >nul

EXIT