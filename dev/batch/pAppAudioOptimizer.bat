@Echo off
CHCP 1252
TITLE pApp OptimizeWin4DJs
if exist %USERPROFILE%\PPDJbatch.txt goto StartTraktorPro
start reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f 
Echo Don't delete this file! The Ultimate Dj Batch file needs it to run fine! >> %USERPROFILE%\PPDJbatch.txt

:StartTraktorPro
COLOR F4
CLS
ECHO.
net stop mpssvc /yes 2>%USERPROFILE%\temp.txt
net stop windefend /yes 2>%USERPROFILE%\temp.txt
net stop "avast! Antivirus" /yes 2>%USERPROFILE%\temp.txt
net stop btwdins /yes 2>%USERPROFILE%\temp.txt
net stop winrm /yes 2>%USERPROFILE%\temp.txt
net stop Broswer /yes 2>%USERPROFILE%\temp.txt
net stop bits /yes 2>%USERPROFILE%\temp.txt
net stop "peerdists vc" /yes 2>%USERPROFILE%\temp.txt
net stop certpropsvc /yes 2>%USERPROFILE%\temp.txt
net stop "Bonjour Service" /yes 2>%USERPROFILE%\temp.txt
net stop bthserv /yes 2>%USERPROFILE%\temp.txt
net stop "ipod service" /yes 2>%USERPROFILE%\temp.txt
net stop "Apple Mobile Device" /yes 2>%USERPROFILE%\temp.txt
net stop AeLookupSvc /yes 2>%USERPROFILE%\temp.txt
net stop stisvc /yes 2>%USERPROFILE%\temp.txt
net stop hpqddsvc /yes 2>%USERPROFILE%\temp.txt
net stop hpslpsvc /yes 2>%USERPROFILE%\temp.txt
net stop WMPnetworksvc /yes 2>%USERPROFILE%\temp.txt
net stop tabletinputservice /yes 2>%USERPROFILE%\temp.txt
net stop bdesvc /yes 2>%USERPROFILE%\temp.txt
net stop wbengine /yes 2>%USERPROFILE%\temp.txt
net stop uiodetect /yes 2>%USERPROFILE%\temp.txt
net stop defragsvc /yes 2>%USERPROFILE%\temp.txt
net stop axinstsv /yes 2>%USERPROFILE%\temp.txt
net stop "w32time" /yes 2>%USERPROFILE%\temp.txt
net stop wercplsupport /yes 2>%USERPROFILE%\temp.txt
net stop PnkBstrA /yes 2>%USERPROFILE%\temp.txt
net stop TeamViewer6 /yes 2>%USERPROFILE%\temp.txt
net stop HPSLPSVC /yes 2>%USERPROFILE%\temp.txt
net stop Wsearch /yes 2>%USERPROFILE%\temp.txt
net stop NAUpdate /yes 2>%USERPROFILE%\temp.txt
net stop spooler /yes 2>%USERPROFILE%\temp.txt
Taskkill /f /im TeamViewer.exe 2>%USERPROFILE%\temp.txt
Taskkill /im firefox.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im uTorrent.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im Dropbox.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im steam.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im "AAM Updates Notifier.exe" 2>%USERPROFILE%\temp.txt
Taskkill /f /im AvastUI.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im BTTray.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im hpqtra08.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im hpwuschd2.exe  2>%USERPROFILE%\temp.txt
Taskkill /f /im iexplorer.exe 2>%USERPROFILE%\temp.txt
Taskkill /im ramsaverpro.exe 2>%USERPROFILE%\temp.txt
if exist %USERPROFILE%\temp.txt del %USERPROFILE%\temp.txt
CLS
COLOR F0
ECHO. %L%PC wurde Optimiert!
ECHO. %L%Starte Traktor 4...
ECHO.
ECHO. %L%Fenster nicht schliessen...
ECHO.
CALL "%ProgramFiles%\Native Instruments\Traktor Pro 4\Traktor Pro 4.exe"
GOTO WAITLOOP

:WAITLOOP
tasklist /FI "%ProgramFiles%\Native Instruments\Traktor Pro 4\Traktor Pro 4.exe" 2>NUL | find /I /N "Traktor Pro 4.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING
goto StopTraktorPro

:RUNNING
ping 9.9.9.9
goto WAITLOOP

:StopTraktorPro
COLOR F2
CLS
ECHO. %L%Restoring everything for normal use!
if exist "%SYSTEMDRIVE%\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "%SYSTEMDRIVE%\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe"
if exist "%SYSTEMDRIVE%\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "%SYSTEMDRIVE%\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe"


net start mpssvc 2>%USERPROFILE%\temp.txt
net start btwdins 2>%USERPROFILE%\temp.txt
net start bits 2>%USERPROFILE%\temp.txt
net start peerdistsvc 2>%USERPROFILE%\temp.txt
net start certpropsvc 2>%USERPROFILE%\temp.txt
net start winrm 2>%USERPROFILE%\temp.txt
net start Broswer 2>%USERPROFILE%\temp.txt
net start bthserv 2>%USERPROFILE%\temp.txt
net start AeLookupSvc 2>%USERPROFILE%\temp.txt
net start UxSms 2>%USERPROFILE%\temp.txt
net start stisvc 2>%USERPROFILE%\temp.txt
net start hpqddsvc 2>%USERPROFILE%\temp.txt
net start hpslpsvc 2>%USERPROFILE%\temp.txt
net start tabletinputservice 2>%USERPROFILE%\temp.txt
net start bdesvc 2>%USERPROFILE%\temp.txt
net start wbengine 2>%USERPROFILE%\temp.txt
net start uiodetect 2>%USERPROFILE%\temp.txt
net start defragsvc 2>%USERPROFILE%\temp.txt
net start axinstsv 2>%USERPROFILE%\temp.txt
net start "w32time" 2>%USERPROFILE%\temp.txt
net start wercplsupport 2>%USERPROFILE%\temp.txt
net start PnkBstrA 2>%USERPROFILE%\temp.txt
net start HPSLPSVC 2>%USERPROFILE%\temp.txt
net start Wsearch 2>%USERPROFILE%\temp.txt
net start spooler 2>%USERPROFILE%\temp.txt

Taskkill /im ramsaverpro.exe 2>%USERPROFILE%\temp.txt
if exist %USERPROFILE%\temp.txt del %USERPROFILE%\temp.txt
CLS
ECHO. %L%Stoppe Traktor 4...
ECHO. %L%Traktor wurde gestoppt...
ECHO.
GOTO Quit

:Quit
COLOR F0
CLS
ECHO.
ECHO. %L%Thanks for using!
ECHO. 
exit