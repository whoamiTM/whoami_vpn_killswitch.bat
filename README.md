# whoami_vpn_killswitch.bat
**VPN Kill Switch using route.exe for Windows**

This kill switch uses route.exe to set a static route to the vpn server and deletes the default route to protect your Windows machine from exposing your true IP if the VPN connection were to drop.
Works with any version of Windows.

# Change Log:
- v1.0 Added option for setting a static route to VPN server.

# How To Use:

**To enable the kill switch.**
- Open the .bat (if you have UAC enabled it will prompt for permission to run).

- Confirm your routers default gateway IP is desplayed correctly. If not Press "4" to enter it manually.

- Press "1" and enter the ip address of the VPN you are connecting to.

- Press "2" to enable the kill switch adding a static route to your VPN server and deleting the default route, killing all other routes to the internet from your local machine in case the VPN connection were to drop.

- Connect to the VPN... ***If you connect to the VPN before Enabling the Kill Switch it will not work.***


**To disable the kill switch**
- Disconnect from the VPN.

- Press "3" to disable the kill switch restoring the default route.

- Press "x" to exit

***route.exe stores routes in RAM which are not persistent. A reboot will correct any routing issue caused by this kill switch.***

# Donation:
- ETH: 0xc8FcbA4600090510102bF425D6754a337b4dB113
- BTC: 37m7Ybc5RJHgYfCZhBJ9hbx6XEF3iHoWLT

# Credits:
- Liquid VPN for v0.1
