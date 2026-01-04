@ECHO OFF
CHCP 1252
TITLE (c) patri.ck
cls
SET L= 
SET ORDNER=%CD%

:MENU
ECHO.
ECHO ===========================================
ECHO.
ECHO %L%%L%%L%%L%%L%[ 1 ] - hole Logcat
ECHO %L%%L%%L%%L%%L%[ 2 ] - hole Radio Log
ECHO.
ECHO %L%%L%%L%%L%%L%[ X ] - Exit
ECHO.
ECHO ===========================================
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2 oder Exit^?
IF %M%==1 GOTO LOGCAT
IF %M%==2 GOTO RADiO
IF %M%==x GOTO EOF

:LOGCAT
adb logcat -d > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_LOGCAT.txt
GOTO MENU

:RADiO
adb logcat -db radio > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_RADIO.txt
GOTO MENU

:EOF
adb kill-server
EXIT