@ECHO OFF
CHCP 1252
COLOR FD
MODE CON:COLS=100 LINES=25
SETLOCAL EnableDelayedExpansion
SET L= 
CLS


:START
ECHO.
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%                     ллллл               ллл              ллллл     
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%                     ААллл               ААА              ААллл      
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% лллллллл   лллллл   ллллллл   лллллллл  лллл      лллллл  Аллл ллллл
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%ААлллААллл АААААллл АААлллА   ААлллААлллААллл     лллААллл АлллААллл 
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% Аллл Аллл  ллллллл   Аллл     Аллл ААА  Аллл    Аллл ААА  АллллллА  
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% Аллл Аллл лллААллл   Аллл ллл Аллл      Аллл    Аллл  ллл АлллААллл 
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% Аллллллл ААлллллллл  ААллллл  ллллл     ллллл ллААлллллл  лллл ллллл
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% АлллААА   АААААААА    ААААА  ААААА     ААААА АА  АААААА  АААА ААААА 
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% Аллл                                                                
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L% ллллл                    PROUDLY PRESENTZ
ECHO %L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%%L%ААААА
ECHO ===============================================================================================================================================================
ECHO %L%%L%%L%%L%%L%[ 1 ] - SFC ScanNow
ECHO %L%%L%%L%%L%%L%[ 2 ] - DISM Check Health
ECHO %L%%L%%L%%L%%L%[ 3 ] - DISM Scan Health
ECHO %L%%L%%L%%L%%L%[ 4 ] - DISM Restore Health
ECHO.
ECHO %L%%L%%L%%L%%L%[ 0 ] - Exit
ECHO ===============================================================================================================================================================
ECHO.
SET /P M=%L%%L%%L%%L%%L%1, 2, 3 oder 4^?%L%%L%
IF %M%==1 GOTO SFC
IF %M%==2 GOTO CHECK
IF %M%==3 GOTO SCAN
IF %M%==4 GOTO RESTORE
IF %M%==0 GOTO ENDE

:SFC
SFC /ScanNow
GOTO START

:CHECK
dism /Online /Cleanup-Image /CheckHealth
GOTO START

:SCAN
dism /Online /Cleanup-Image /ScanHealth
GOTO START

:RESTORE
dism /Online /Cleanup-Image /RestoreHealth /LimitAccess
GOTO START


:ENDE
PAUSE >NUL
EXIT