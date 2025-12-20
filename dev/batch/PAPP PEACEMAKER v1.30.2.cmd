@ECHO OFF
CHCP 1252
TITLE PAPP PEACEMAKER v1.30.2
CLS

ECHO.
ECHO.
ECHO.
ECHO %L%%L%%L%Suche Administrator Rechte.
SET L= 

OPENFILES >NUL 2>&1
IF %ERRORLEVEL% EQU 0 (

  CLS
  COLOR F2
  ECHO %L%%L%%L%Administrator Rechte gefunden.
  ECHO.
  ECHO %L%%L%%L%Hosts file: %WINDIR%\system32\drivers\etc\hosts
  ECHO.
  
  SETLOCAL ENABLEDELAYEDEXPANSION
	SET BLOCKLINE=127.0.0.1 live.virtualdj.com
	ECHO %L%%L%%L%Check: !BLOCKLINE!
	FIND /C /I "!BLOCKLINE!" "%WINDIR%\system32\drivers\etc\hosts" >NUL 2>NUL
	IF !ERRORLEVEL! NEQ 0 (
	  CLS
      ECHO.
	  ECHO %L%%L%%L%Zeile nicht gefunden, wird geadded...
	  ECHO .>>%WINDIR%\system32\drivers\etc\hosts
	  ECHO !BLOCKLINE!>>%WINDIR%\system32\drivers\etc\hosts
	) ELSE (
	
      ECHO.
	  ECHO %L%%L%%L%Zeile gefunden.
	)
    ECHO.
  ENDLOCAL
  
  COLOR F2
  ECHO.
  ECHO %L%%L%%L%Patchen erfolgreich...

) ELSE (
  COLOR F4
  ECHO.
  ECHO %L%%L%%L%Administrator Rechte nicht gefunden!
  ECHO %L%%L%%L%Du brauchst Administrator Rechte!
  ECHO.
  ECHO %L%%L%%L%Beliebige Taste zum beenden...
)
PAUSE >nul