@echo off
@setlocal enableextensions
@cd /d "%~dp0"
cls

for /f "tokens=3 delims= " %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ ^| findstr "REG_SZ"') do set currentValue=%%a
echo Current Proxy Value: %currentValue%

for /f "tokens=2 delims==" %%F in ('wmic nic where "NetConnectionStatus=2 and AdapterTypeId=0" get  NetConnectionID /format:list') do set interfaceName=%%F

echo Your Interface is %interfaceName%


:MENU

echo Select:
echo [0] Setup
echo [1] Connect
echo [2] Disconnect
echo [3] Exit

:choice
set /p "choice=[Please enter a number]? "
if %choice%==0 goto setup
if %choice%==1 goto 1
if %choice%==2 goto 2
if %choice%==3 goto end
echo Invalid Choice
goto MENU


:SETUP
curl https://the.earth.li/~sgtatham/putty/0.78/w64/plink.exe -o plink.exe
echo "Downloaded plink.exe"
curl https://altushost-swe.dl.sourceforge.net/project/dns2socks/DNS2SOCKS.exe
echo "Downloaded DNS2SOCKS"
echo
goto MENU

:1
set /p "ip=Enter IP:"
set /p "username=Enter Username:"
set /p "port=Port:"


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer  /d "socks=localhost:6060;" /t REG_SZ /f

netsh interface ipv4 add dnsserver "%interfaceName%" 127.0.0.1

start /B "DNS" "%~dp0dns2socks.exe" 127.0.0.1:6060 8.8.8.8:53 127.0.0.1:53
timeout 2
start "TUNNEL" "ssh" %username%@%ip% -D 6060 -p %port%


goto MENU


:2
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer  /d "" /t REG_SZ /f
netsh interface ipv4 set dnsserver "%interfaceName%" source=dhcp
netsh interface ipv4 set dnsserver "%interfaceName%" source=dhcp
TASKKILL /FI "WINDOWTITLE eq DNS"
TASKKILL /FI "WINDOWTITLE eq TUNNEL"

goto end


:end
PAUSE
