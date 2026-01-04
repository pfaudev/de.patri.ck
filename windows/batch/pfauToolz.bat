@ECHO OFF
CHCP 1252
TiTLE (c) patr.ck
cls
SET L= 
SET ORDNER=%CD%


:MENU
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= PFAUTOOLZ ========= 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] -  DiSM CONTROL     บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] -  LOGCAT HANDLER   บ
ECHO %L%%L%%L%%L%%L%บ  [ 3 ] -  SYSTEM CLEANER   บ
ECHO %L%%L%%L%%L%%L%บ  [ 4 ] -  MOBiLE TOOLZ     บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ                  [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2, 3 oder 4^?%L%%L%
iF %M%==1 GOTO DiSMMENU
iF %M%==2 GOTO LOGCATMENU
iF %M%==3 GOTO CLEANSYS
iF %M%==4 GOTO MOBiLETOOLS
iF %M%==0 GOTO EOF


:MOBiLETOOLS
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ ======= 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] -  ADB              บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] -  FASTBOOT         บ
ECHO %L%%L%%L%%L%%L%บ  [ 3 ] -  LOGS             บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [B] BACK    บ   [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2 oder Exit^? %L%
iF %M%==1 GOTO ADBMENU
iF %M%==2 GOTO FASTBOOTMENU
iF %M%==3 GOTO LOGMENU
iF %M%==b GOTO MENU
iF %M%==x GOTO EOF


:ADBMENU
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ/ADB === 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1]  - DEViCES           บ
ECHO %L%%L%%L%%L%%L%บ  [ 2]  - REBOOT            บ
ECHO %L%%L%%L%%L%%L%บ  [ 3]  - REBOOT BOOTLOADER บ
ECHO %L%%L%%L%%L%%L%บ  [ 4]  - REBOOT RECOVERY   บ
ECHO %L%%L%%L%%L%%L%บ  [ 5]  - GET-SERiALNO      บ
ECHO %L%%L%%L%%L%%L%บ  [ 6]  - GET-STATE         บ
ECHO %L%%L%%L%%L%%L%บ  [ 7]  - START-SERVER      บ	
ECHO %L%%L%%L%%L%%L%บ  [ 8]  - KiLL-SERVER       บ
ECHO %L%%L%%L%%L%%L%บ  [ 9]  - SHELL             บ
ECHO %L%%L%%L%%L%%L%บ  [10] -  UNiNSTALL APP     บ
ECHO %L%%L%%L%%L%%L%บ  [11] -  LiST PACKAGES     บ
ECHO %L%%L%%L%%L%%L%บ  [12] -  3RDPARTY PACKS    บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [B] BACK    บ   [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%Bitte waehlen^! %L%
iF %M%==1 GOTO ADBEiNS
iF %M%==2 GOTO ADBZWEi
iF %M%==3 GOTO ADBDREi
iF %M%==4 GOTO ADBViER
iF %M%==5 GOTO ADBFUNF
iF %M%==6 GOTO ADBSECHS
iF %M%==7 GOTO ADBSiEBEN
iF %M%==8 GOTO ADBACHT
iF %M%==9 GOTO ADBNEUN
iF %M%==10 GOTO ADBZEHN
iF %M%==11 GOTO ADBELF
iF %M%==12 GOTO ADBZWOLF
iF %M%==z GOTO MOBiLETOOLS
iF %M%==x GOTO KiLLADB


:FASTBOOTMENU
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ/ADB === 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] - DEVICES           บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] - OEM UNLOCK        บ
ECHO %L%%L%%L%%L%%L%บ  [ 3 ] - OEM LOCK          บ
ECHO %L%%L%%L%%L%%L%บ  [ 4 ] - REBOOT BOOTLOADER บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [B] BACK    บ   [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%Bitte waehlen^! %L%
iF %M%==1 GOTO FASTBOOTEiNS
iF %M%==2 GOTO FASTBOOTZWEi
iF %M%==3 GOTO FASTBOOTDREi
iF %M%==4 GOTO FASTBOOTViER
iF %M%==z GOTO MOBiLETOOLS
iF %M%==x GOTO KiLLADB


:LOGMENU
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ/ADB === 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] - LOGCAT            บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] - RADiO             บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [B] BACK    บ   [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%Bitte waehlen^! %L%
iF %M%==1 GOTO LOGCAT2
iF %M%==2 GOTO RADiO2
iF %M%==z GOTO MOBiLETOOLS
iF %M%==x GOTO KiLLADB


:ADBEiNS
adb devices
pause >nul
GOTO ADBMENU


:ADBZWEi
adb reboot
GOTO ADBMENU


:ADBDREi
adb reboot bootloader
GOTO ADBMENU


:ADBViER
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

:ADBSiEBEN
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
adb shell pm uninstall -k โ€“user 0 %PACKAGE%
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

:FASTBOOTEiNS
adb devices
pause >nul
GOTO ADBMENU

:FASTBOOTZWEi
fastboot oem unlock
pause >nul
GOTO ADBMENU

:FASTBOOTDREi
fastboot oem lock
pause >nul
GOTO ADBMENU

:FASTBOOTViER
fastboot reboot bootloader
GOTO ADBMENU

:LOGCAT2
adb logcat -d > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_LOGCAT.txt
GOTO MENU

:RADiO2
adb logcat -db radio > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_RADiO.txt
GOTO MENU

:CLEANSYS
DEL /f /s /q %systemdrive%\*.tmp
DEL /f /s /q %systemdrive%\*._mp
DEL /f /s /q %systemdrive%\*.log
DEL /f /s /q %systemdrive%\*.gid
DEL /f /s /q %systemdrive%\*.chk
DEL /f /s /q %systemdrive%\*.old
DEL /f /s /q %systemdrive%\recycled\*.*
DEL /f /s /q %windir%\*.bak
DEL /f /s /q %windir%\prefetch\*.*
RD /s /q %windir%\temp & md %windir%\temp
DEL /f /q %userprofile%\cookies\*.*
DEL /f /q %userprofile%\recent\*.*
DEL /f /s /q %userprofile%\Local Settings\Temporary internet Files\*.*
DEL /f /s /q %userprofile%\Local Settings\Temp\*.*
DEL /f /s /q %userprofile%\recent\*.*
PAUSE
GOTO MENU

:LOGCATMENU
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ/ADB === 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] - hole Logcat       บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] - hole Radio Log    บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ                  [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2 oder Exit^?
iF %M%==1 GOTO LOGCAT
iF %M%==2 GOTO RADiO
iF %M%==x GOTO KiLLADB

:LOGCAT
adb logcat -d > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_LOGCAT.txt
GOTO LOGCATMENU

:RADiO
adb logcat -db radio > %ORDNER%\%date:~6,4%-%date:~3,2%-%date:~0,2%_RADiO.txt
GOTO LOGCATMENU

:KiLLADB
adb kill-server
GOTO EOF

:DiSMMENU
CLS
ECHO %L%%L%%L%%L%%L%ษออออออออออออออออออออออออออออป
ECHO %L%%L%%L%%L%%L%บ= MOBiLETOOLZ/ADB === 2024 =บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ  [ 1 ] - SFC ScanNow       บ
ECHO %L%%L%%L%%L%%L%บ  [ 2 ] - DiSM Check        บ
ECHO %L%%L%%L%%L%%L%บ  [ 3 ] - DiSM Scan         บ
ECHO %L%%L%%L%%L%%L%บ  [ 4 ] - DiSM Restore      บ
ECHO %L%%L%%L%%L%%L%ฬออออออออออออออออออออออออออออน
ECHO %L%%L%%L%%L%%L%บ                  [X] EXiT  บ
ECHO %L%%L%%L%%L%%L%ศออออออออออออออออออออออออออออผ
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2, 3 oder 4^?%L%%L%
iF %M%==1 GOTO DiSMSFC
iF %M%==2 GOTO DiSMCHECK
iF %M%==3 GOTO DiSMSCAN
iF %M%==4 GOTO DiSMRESTORE
iF %M%==0 GOTO EOF

:DiSMSFC
SFC /ScanNow
GOTO DiSMMENU

:DiSMCHECK
dism /Online /Cleanup-image /CheckHealth
GOTO DiSMMENU

:DiSMSCAN
dism /Online /Cleanup-image /ScanHealth
GOTO DiSMMENU

:DiSMRESTORE
dism /Online /Cleanup-image /RestoreHealth /LimitAccess
GOTO DiSMMENU

:EOF
EXiT