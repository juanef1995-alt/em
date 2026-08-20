@echo off
setlocal

set "APP=%~dp0index.html"
set "CHROME1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME3=%LocalAppData%\Google\Chrome\Application\chrome.exe"

if exist "%CHROME1%" (
  start "" "%CHROME1%" --kiosk-printing "%APP%"
) else if exist "%CHROME2%" (
  start "" "%CHROME2%" --kiosk-printing "%APP%"
) else if exist "%CHROME3%" (
  start "" "%CHROME3%" --kiosk-printing "%APP%"
) else (
  echo No se encontro Google Chrome instalado en este equipo.
  echo Instalalo desde https://www.google.com/chrome/ y volve a intentar.
  pause
)
