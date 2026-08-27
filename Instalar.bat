@echo off
setlocal enabledelayedexpansion

set "SRC=%~dp0"
set "DEST=%LocalAppData%\EtiquetasNIC"
set "PROFILE=%LocalAppData%\EtiquetasNIC-ChromeProfile"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\Etiquetas NIC.lnk"

if not exist "%SRC%index.html" (
  echo No se encontro index.html en esta carpeta. Ejecuta este instalador
  echo desde la misma carpeta donde lo descomprimiste.
  pause
  exit /b 1
)

set "CHROME1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME3=%LocalAppData%\Google\Chrome\Application\chrome.exe"
set "CHROME="
if exist "%CHROME1%" set "CHROME=%CHROME1%"
if not defined CHROME if exist "%CHROME2%" set "CHROME=%CHROME2%"
if not defined CHROME if exist "%CHROME3%" set "CHROME=%CHROME3%"

if not defined CHROME (
  echo No se encontro Google Chrome instalado en este equipo.
  echo Instalalo desde https://www.google.com/chrome/ y volve a ejecutar este instalador.
  pause
  exit /b 1
)

echo Instalando la app en "%DEST%"...
mkdir "%DEST%" >nul 2>&1
copy /y "%SRC%index.html" "%DEST%\index.html" >nul
if exist "%SRC%nic.ico" copy /y "%SRC%nic.ico" "%DEST%\nic.ico" >nul

set "TARGET_URL=file:///%DEST:\=/%/index.html"

echo Creando el icono "Etiquetas NIC" en el escritorio...
set "PS1=%TEMP%\instalar_etiquetas_nic.ps1"
> "%PS1%" echo $s = (New-Object -ComObject WScript.Shell).CreateShortcut('%SHORTCUT%')
>>"%PS1%" echo $s.TargetPath = '%CHROME%'
>>"%PS1%" echo $s.Arguments = '--kiosk-printing --no-first-run --no-default-browser-check --user-data-dir="%PROFILE%" "%TARGET_URL%"'
>>"%PS1%" echo $s.IconLocation = '%DEST%\nic.ico'
>>"%PS1%" echo $s.WorkingDirectory = '%DEST%'
>>"%PS1%" echo $s.Description = 'Ordenador de Etiquetas por NIC'
>>"%PS1%" echo $s.Save()

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%"
del "%PS1%" >nul 2>&1

echo.
if exist "%SHORTCUT%" (
  echo Listo. Ya tenes el icono "Etiquetas NIC" en el escritorio.
  echo A partir de ahora usa siempre ese icono para abrir la app: abre
  echo directo en modo automatico, sin cartel de impresion al escanear.
  echo.
  echo Esta carpeta ya no hace falta conservarla: la app quedo copiada
  echo en "%DEST%".
) else (
  echo No se pudo crear el icono automaticamente. Revisa el mensaje de
  echo arriba, o avisa para que te ayuden a armarlo a mano.
)
echo.
pause
