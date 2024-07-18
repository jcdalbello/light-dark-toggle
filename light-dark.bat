@echo off
set KEY_NAME=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize
set VALUE_NAME=AppsUseLightTheme

FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query %KEY_NAME% /v %VALUE_NAME%') DO set "VALUE=%%B"

set NEW_VALUE=0x0

if %VALUE%==0x0 (
	set NEW_VALUE=0x1
)

reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d %NEW_VALUE% /f

set VALUE_NAME=SystemUsesLightTheme

reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d %NEW_VALUE% /f

REM matar y reiniciar el proceso de explorer.exe para que la barra de tareas se actualice
taskkill /im explorer.exe /f

start explorer.exe
