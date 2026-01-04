@ECHO OFF
CHCP 1252
TITLE MobileToolz (c) patri.ck
cls
SET L= 
SET ORDNER=%CD%

:1STMENU
CLS
ECHO %L%%L%%L%%L%mobileToolz 2c24
ECHO %L%%L%===========================================%L%%L%
ECHO %L%%L%%L%%L%%L%[ 1 ] - ADB
ECHO %L%%L%%L%%L%%L%[ 2 ] - FASTBOOT
ECHO %L%%L%%L%%L%%L%[ 3 ] - LOGS
ECHO.
ECHO %L%%L%%L%%L%%L%[ X ] - Exit
ECHO %L%%L%===========================================%L%%L%
SET /P M=%L%%L%%L%%L%%L%1, 2 oder Exit^? %L%
IF %M%==1 GOTO ADBMENU
IF %M%==2 GOTO FASTBOOTMENU
IF %M%==3 GOTO LOGMENU
IF %M%==x GOTO EOF

:ADBMENU
CLS
ECHO %L%%L%%L%%L%mobileToolz 2c24 -^> ADB
ECHO %L%%L%===========================================%L%%L%
ECHO %L%%L%%L%%L%%L%[ 1 ]  - devices
ECHO %L%%L%%L%%L%%L%[ 2 ]  - reboot
ECHO %L%%L%%L%%L%%L%[ 3 ]  - reboot bootloader
ECHO %L%%L%%L%%L%%L%[ 4 ]  - reboot recovery
ECHO %L%%L%%L%%L%%L%[ 5 ]  - get-serialno
ECHO %L%%L%%L%%L%%L%[ 6 ]  - get-state
ECHO %L%%L%%L%%L%%L%[ 7 ]  - start-server 	
ECHO %L%%L%%L%%L%%L%[ 8 ]  - kill-server
ECHO %L%%L%%L%%L%%L%[ 9 ]  - shell
ECHO %L%%L%%L%%L%%L%[ 10 ] - uninstall App
ECHO %L%%L%%L%%L%%L%[ 11 ] - list packages 	
ECHO %L%%L%%L%%L%%L%[ 12 ] - list 3rd Party packages
ECHO.
ECHO %L%%L%%L%%L%%L%[ Z ] - Zurück
ECHO %L%%L%%L%%L%%L%[ X ] - Exit
ECHO %L%%L%===========================================%L%%L%
SET /P M=%L%%L%%L%%L%%L%Bitte wählen^! %L%
IF %M%==1 GOTO ADBEINS
IF %M%==2 GOTO ADBZWEI
IF %M%==3 GOTO ADBDREI
IF %M%==4 GOTO ADBVIER
IF %M%==5 GOTO ADBFUNF
IF %M%==6 GOTO ADBSECHS
IF %M%==7 GOTO ADBSIEBEN
IF %M%==8 GOTO ADBACHT
IF %M%==9 GOTO ADBNEUN
IF %M%==10 GOTO ADBZEHN
IF %M%==11 GOTO ADBELF
IF %M%==12 GOTO ADBZWOLF
IF %M%==z GOTO 1STMENU
IF %M%==x GOTO EOF

:FASTBOOTMENU
CLS
ECHO %L%%L%%L%%L%mobileToolz 2c24 -^> FASTBOOT
ECHO %L%%L%===========================================%L%%L%
ECHO %L%%L%%L%%L%%L%[ 1 ]  - devices
ECHO %L%%L%%L%%L%%L%[ 2 ]  - oem unlock
ECHO %L%%L%%L%%L%%L%[ 3 ]  - oem lock
ECHO %L%%L%%L%%L%%L%[ 4 ]  - reboot bootloader
ECHO.
ECHO %L%%L%%L%%L%%L%[ Z ] - Zurück
ECHO %L%%L%%L%%L%%L%[ X ] - Exit
ECHO %L%%L%===========================================%L%%L%
SET /P M=%L%%L%%L%%L%%L%Bitte wählen^! %L%
IF %M%==1 GOTO FASTBOOTEINS
IF %M%==2 GOTO FASTBOOTZWEI
IF %M%==3 GOTO FASTBOOTDREI
IF %M%==4 GOTO FASTBOOTVIER
IF %M%==z GOTO 1STMENU
IF %M%==x GOTO EOF

:LOGMENU
CLS
ECHO %L%%L%%L%%L%mobileToolz 2c24 -^> LOGS
ECHO %L%%L%===========================================%L%%L%
ECHO %L%%L%%L%%L%%L%[ 1 ] - LOGCAT
ECHO %L%%L%%L%%L%%L%[ 2 ] - RADiO
ECHO.
ECHO %L%%L%%L%%L%%L%[ Z ] - Zurück
ECHO %L%%L%%L%%L%%L%[ X ] - Exit
ECHO %L%%L%===========================================%L%%L%
SET /P M=%L%%L%%L%%L%%L%Bitte wählen^! %L%
IF %M%==1 GOTO LOGCAT
IF %M%==2 GOTO RADiO
IF %M%==z GOTO 1STMENU
IF %M%==x GOTO EOF


:ADBEINS
adb devices
pause >nul
GOTO ADBMENU

:ADBZWEI
adb reboot
GOTO ADBMENU

:ADBDREI
adb reboot bootloader
GOTO ADBMENU

:ADBVIER
adb reboot recovery
GOTO ADBMENU

:ADBFUNF
adb get-serialno
pause >nul
GOTO ADBMENU

:ADBSECHS
adb get-state
pause >nul
GOTO ADBMENU

:ADBSIEBEN
adb start-server
GOTO ADBMENU

:ADBACHT
adb kill-server
GOTO ADBMENU

:ADBNEUN
adb shell
pause >nul
GOTO ADBMENU

:ADBZEHN
SET /P PACKAGE= Bitte Paketnamen eingeben:
adb shell pm uninstall -k –user 0 %PACKAGE%
pause >nul
GOTO ADBMENU

:ADBELF
adb shell pm list packages
pause >nul
GOTO ADBMENU

:ADBZWOLF
adb shell pm list packages -3
pause >nul
GOTO ADBMENU

:FASTBOOTEINS
adb devices
pause >nul
GOTO ADBMENU

:FASTBOOTZWEI
fastboot oem unlock
pause >nul
GOTO ADBMENU

:FASTBOOTDREI
fastboot oem lock
pause >nul
GOTO ADBMENU

:FASTBOOTVIER
fastboot reboot bootloader
GOTO ADBMENU

:LOGCAT
adb logcat -d > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_LOGCAT.txt
GOTO MENU

:RADiO
adb logcat -db radio > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_RADIO.txt
GOTO MENU

:EOF
adb kill-server
EXIT