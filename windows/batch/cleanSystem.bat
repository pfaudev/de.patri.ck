@ECHO OFF
CHCP 1252
ECHO Cleaning junk files, please wait...

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
DEL /f /s /q %userprofile%\Local Settings\Temporary Internet Files\*.*
DEL /f /s /q %userprofile%\Local Settings\Temp\*.*
DEL /f /s /q %userprofile%\recent\*.*

echo finished!

echo. & pause