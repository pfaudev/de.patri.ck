@ECHO OFF
CHCP 1252
TITLE (c) ᴘᴀᴛʀɪ.ᴄᴋ
cls
SET L= 

:MENU
ECHO.
ECHO ===========================================
ECHO.
ECHO %L%%L%%L%%L%%L%[ 1 ] - SFC ScanNow
ECHO %L%%L%%L%%L%%L%[ 2 ] - DISM Check Health
ECHO %L%%L%%L%%L%%L%[ 3 ] - DISM Scan Health
ECHO %L%%L%%L%%L%%L%[ 4 ] - DISM Restore Health
ECHO.
ECHO %L%%L%%L%%L%%L%[ 0 ] - Exit
ECHO.
ECHO ===========================================
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2, 3 oder 4^?%L%%L%
IF %M%==1 GOTO SFC
IF %M%==2 GOTO CHECK
IF %M%==3 GOTO SCAN
IF %M%==4 GOTO RESTORE
IF %M%==0 GOTO EOF

:SFC
SFC /ScanNow
GOTO MENU

:CHECK
dism /Online /Cleanup-Image /CheckHealth
GOTO MENU

:SCAN
dism /Online /Cleanup-Image /ScanHealth
GOTO MENU

:RESTORE
dism /Online /Cleanup-Image /RestoreHealth /LimitAccess
GOTO MENU

:EOF
EXIT