@ECHO OFF
CHCP 1252
TITLE MEGACMD LiSTMAKER
CLS
SET L= 

:MENU
CLS
ECHO ===========================================================
ECHO = ARCHiV                                                  =
ECHO =  [  1 ] -  AUFNAHMEN        [  2 ] -  PLATTEN           =
ECHO =  [  3 ] -  COMPiLATiONZ     [  4 ] -  RELEASES          =
ECHO =  [  5 ] -  LiVESETS         [  6 ] -  LOSSLESS          =
ECHO ===========================================================
ECHO = BACKUP                                                  =
ECHO =  [  B ] -  BACKUP                                       =
ECHO ===========================================================
ECHO = PLATTENKOFFER                                           =
ECHO =  [  7 ] -  BEATPORT         [  8 ] -  DJTOOLS           =
ECHO =  [  9 ] -  LOSSLESS         [ 10 ] -  PLATTEN           =
ECHO =  [ 11 ] -  PLAYLiST         [ 12 ] -  TRACKPACKZ        =
ECHO =  [ 13 ] -  TRAKTORSTEMS                                 =
ECHO ===========================================================
ECHO =                             [  x ] -  EXiT              =
ECHO ===========================================================
ECHO.
SET /P M=Bitte waehlen%L%%L%
iF %M%==1 GOTO AREC
iF %M%==2 GOTO APLA
iF %M%==3 GOTO ACOMP
iF %M%==4 GOTO AREL
iF %M%==5 GOTO ALIVE
iF %M%==6 GOTO ALOS

iF %M%==7 GOTO PBEAT
iF %M%==8 GOTO PTOOL
iF %M%==9 GOTO PLOS
iF %M%==10 GOTO PPLA
iF %M%==11 GOTO PPLAY
iF %M%==12 GOTO PPACK
iF %M%==13 GOTO PSTEM

iF %M%==b GOTO BACK
iF %M%==x GOTO EOF
GOTO END

:AREC
%MEGA% ls -r /ARCHiV/AUFNAHMEN > "D:\_MEGA\ARCHiV_AUFNAHMEN.txt"
ECHO D:\_MEGA\ARCHiV_AUFNAHMEN.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO AREC-JA
iF %A%==n GOTO MENU
GOTO MENU

:APLA
%MEGA% ls -r /ARCHiV/PLATTEN > "D:\_MEGA\ARCHiV_PLATTEN.txt"
ECHO D:\_MEGA\ARCHiV_PLATTEN.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO APLA-JA
iF %A%==n GOTO MENU
GOTO MENU

:ACOMP
%MEGA% ls -r /ARCHiV/PLATTEN > "D:\_MEGA\ARCHiV_PLATTEN.txt"
ECHO D:\_MEGA\ARCHiV_PLATTEN.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO APLA-JA
iF %A%==n GOTO MENU
GOTO MENU

:AREL
%MEGA% ls -r /ARCHiV/RELEASES > "D:\_MEGA\ARCHiV_RELEASES.txt"
ECHO D:\_MEGA\ARCHiV_RELEASES.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO AREL-JA
iF %A%==n GOTO MENU
GOTO MENU

:ALIVE
%MEGA% ls -r /ARCHiV/LiVESETS > "D:\_MEGA\ARCHiV_LiVESETS.txt"
ECHO D:\_MEGA\ARCHiV_LiVESETS.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO ALIVE-JA
iF %A%==n GOTO MENU
GOTO MENU

:PBEAT
%MEGA% ls -r /PLATTENKOFFER/BEATPORT > "D:\_MEGA\BEATPORT.txt"
ECHO D:\_MEGA\BEATPORT.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PBEAT-JA
iF %A%==n GOTO MENU
GOTO MENU

:PTOOL
%MEGA% ls -r /PLATTENKOFFER/DJTOOLS > "D:\_MEGA\DJTOOLS.txt"
ECHO D:\_MEGA\DJTOOLS.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PTOOL-JA
iF %A%==n GOTO MENU
GOTO MENU

:PLOS
%MEGA% ls -r /PLATTENKOFFER/LOSSLESS > "D:\_MEGA\LOSSLESS.txt"
ECHO D:\_MEGA\LOSSLESS.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PLOS-JA
iF %A%==n GOTO MENU
GOTO MENU

:PPLA
%MEGA% ls -r /PLATTENKOFFER/PLATTEN > "D:\_MEGA\PLATTEN.txt"
ECHO D:\_MEGA\PLATTEN.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PPLA-JA
iF %A%==n GOTO MENU
GOTO MENU

:PPLAY
%MEGA% ls -r /PLATTENKOFFER/PLAYLiSTS > "D:\_MEGA\PLAYLiSTS.txt"
ECHO D:\_MEGA\PLAYLiSTS.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PPLAY-JA
iF %A%==n GOTO MENU
GOTO MENU

:PPACK
%MEGA% ls -r /PLATTENKOFFER/TRACKPACKZ > "D:\_MEGA\TRACKPACKZ.txt"
ECHO D:\_MEGA\TRACKPACKZ.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PPACK-JA
iF %A%==n GOTO MENU
GOTO MENU

:PSTEM
%MEGA% ls -r /PLATTENKOFFER/TRAKTORSTEMS > "D:\_MEGA\TRAKTORSTEMS.txt"
ECHO D:\_MEGA\TRAKTORSTEMS.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO PSTEM-JA
iF %A%==n GOTO MENU
GOTO MENU

:BACK
%MEGA% ls -r /BACKUP > "D:\_MEGA\BACKUP.txt"
ECHO D:\_MEGA\BACKUP.txt erstellt...
SET /P A=Anzeigen^? J/N%L%%L%
iF %A%==j GOTO BACK-JA
iF %A%==n GOTO MENU
GOTO MENU

:AREC-JA
start notepad D:\_MEGA\ARCHiV_AUFNAHMEN.txt
GOTO MENU

:AREL-JA
start notepad D:\_MEGA\ARCHiV_RELEASES.txt
GOTO MENU

:ALIVE-JA
start notepad D:\_MEGA\ARCHiV_LIVESETS.txt
GOTO MENU

:ACOMP-JA
start notepad D:\_MEGA\ARCHiV_COMPiLATiONZ.txt
GOTO MENU

:APLA-JA
start notepad D:\_MEGA\ARCHiV_PLATTEN.txt
GOTO MENU

:ALOS-JA
start notepad D:\_MEGA\ARCHiV_LOSSLESS.txt
GOTO MENU

:PBEAT-JA
start notepad D:\_MEGA\BEATPORT.txt
GOTO MENU

:PTOOL-JA
start notepad D:\_MEGA\DJTOOLS.txt
GOTO MENU

:PLOS-JA
start notepad D:\_MEGA\LOSSLESS.txt
GOTO MENU

:PPLA-JA
start notepad D:\_MEGA\PLATTEN.txt
GOTO MENU

:PPLAY-JA
start notepad D:\_MEGA\PLAYLISTS.txt
GOTO MENU

:PPACK-JA
start notepad D:\_MEGA\TRACKPACKZ.txt
GOTO MENU

:PSTEM-JA
start notepad D:\_MEGA\TRAKTORSTEMS.txt
GOTO MENU

:BACK-JA
start notepad D:\_MEGA\BACKUP.txt
GOTO MENU

:END
PAUSE >nul
EXIT