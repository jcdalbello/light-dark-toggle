@echo off
REM Set key values
set KEY_NAME=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize
set VALUE_NAME=AppsUseLightTheme

REM get the current value to check which mode is active
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query %KEY_NAME% /v %VALUE_NAME%') DO set "VALUE=%%B"

set NEW_VALUE=0x0

REM 0=dark 1=light
if %VALUE%==0x0 (
	set NEW_VALUE=0x1
)

REM Change the registries value
reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d %NEW_VALUE% /f
set VALUE_NAME=SystemUsesLightTheme
reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d %NEW_VALUE% /f

REM kill and restart explorer.exe to update the taskbar color
taskkill /im explorer.exe /f
start explorer.exe
