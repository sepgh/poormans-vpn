@echo off
cls

for /f "tokens=3 delims= " %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ ^| findstr "REG_SZ"') do set currentValue=%%a
echo Current Proxy Value: %currentValue%

:MENU

echo Select:
echo [0] Setup
echo [1] Connect
echo [2] Disconnect

:choice
set /p "choice=[Please enter a number]? "
if %choice%==0 goto setup
if %choice%==1 goto 1
if %choice%==2 goto 2
echo Invalid Choice
goto MENU


:SETUP
curl https://the.earth.li/~sgtatham/putty/0.78/w64/plink.exe -o plink.exe
echo "Downloaded plink.exe"
echo
goto MENU

:1
set /p "ip=Enter IP:"
set /p "username=Enter Username:"


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer  /d "socks=localhost:6060;" /t REG_SZ /f

plink.exe -ssh %ip% -D 6060 -l %username% -no-antispoof
goto 2


:2
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
goto end

:end
PAUSE