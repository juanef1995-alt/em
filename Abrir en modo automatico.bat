@echo off
setlocal

set "APP=%~dp0index.html"
set "PROFILE=%LocalAppData%\EtiquetasNIC-ChromeProfile"
set "CHROME1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME3=%LocalAppData%\Google\Chrome\Application\chrome.exe"

rem Se usa un perfil de Chrome aparte (--user-data-dir) para que el modo
rem silencioso funcione siempre, aunque ya haya otra ventana de Chrome
rem abierta con el perfil normal.

if exist "%CHROME1%" (
  start "" "%CHROME1%" --kiosk-printing --no-first-run --no-default-browser-check --user-data-dir="%PROFILE%" "%APP%"
) else if exist "%CHROME2%" (
  start "" "%CHROME2%" --kiosk-printing --no-first-run --no-default-browser-check --user-data-dir="%PROFILE%" "%APP%"
) else if exist "%CHROME3%" (
  start "" "%CHROME3%" --kiosk-printing --no-first-run --no-default-browser-check --user-data-dir="%PROFILE%" "%APP%"
) else (
  echo No se encontro Google Chrome instalado en este equipo.
  echo Instalalo desde https://www.google.com/chrome/ y volve a intentar.
  pause
)
