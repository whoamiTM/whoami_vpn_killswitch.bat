@echo off

:: GetAdmin
:-------------------------------------
:: Verify permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: On Error No Admin
if '%errorlevel%' NEQ '0' (
    echo Getting administrative privileges...
    goto DoUAC
) else ( goto getAdmin )

:DoUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:getAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


@echo off
:: CHANGE DEFAULT GW IP BELOW
set defgw=192.168.0.1
set vpn=0.0.0.0


@For /f "tokens=3" %%1 in (
   'route.exe print 0.0.0.0 ^|findstr "\<0.0.0.0.*0.0.0.0\>"') Do set defgw=%%1
cls
:start
cls
echo.
color 0A
echo Simple VPN Kill Switch, ver. 1.0 - by whoami

echo.
echo.
echo Your routers gateway is probably "%defgw%"
echo -if nothing appears or its incorrect, add it manually (Press "4")
echo.
echo.
echo Press "1" and enter VPN IP then
echo enable Kill Switch before connecting VPN
echo.
echo.
echo USAGE: 
echo.
echo -Press "1" to manually insert VPN IP
echo -Press "2" to Enable Kill Switch (IP "%defgw%")
echo -Press "3" to Disable Kill Switch (IP "%defgw%")
echo -Press "4" to manually set default gateway if its not detected above.
echo -Press "h" for Kill Switch Help
echo -Press "x" to exit Kill Switch.
echo.
set /p option=Your option: 
if '%option%'=='1' goto :option1
if '%option%'=='2' goto :option2
if '%option%'=='3' goto :option3
if '%option%'=='4' goto :option4
if '%option%'=='x' goto :exit
if '%option%'=='h' goto :help
echo Insert 1, 2, 3, x or h
timeout 4
goto start
:option1
echo 
set /p vpn=enter your server IP:
echo.
echo VPN IP configured
timeout 4
goto start
:option2
route delete 0.0.0.0 %defgw%
route add %vpn% MASK 255.255.255.255 %defgw%
echo Default gateway "%defgw%" removed
timeout 4
goto start
:option3
route delete %vpn%  
route add 0.0.0.0 mask 0.0.0.0 %defgw%
echo Defaulte gateway "%defgw%" restored
timeout 4
goto start
:option4
echo
set /p defgw=enter your gw IP (e.g. 192.168.0.1): 
goto start
:help
cls
echo.
echo. 
echo ======================
echo This simple kill switch removes your default gateway
echo and blocks traffic from reaching the internet when
echo your VPN gets disconnected.
echo. 
echo Here is how you use it.
echo.
echo Step 1: Open Kill Switch .bat
echo Step 2: Enter your VPN server IP (option "1")
echo Step 3: Enable Kill Switch (option "2")
echo Step 4: Connect to your SoftEther or OpenVPN server.
echo.
echo Now internet traffic will only pass through the VPN.
echo. 
echo If your VPN gets disconnected so will your internet
echo until the VPN reconnects.
echo.
echo.
echo When you disconnect from the VPN follow these steps
echo to browse the internet normally.
echo.
echo Step 1: Close any software that may leak your real IP
echo Step 2: Disconnect VPN
echo Step 3: Disable the VPN kill switch (Option "3")
echo.
timeout /T -1
goto start
:exit
exit