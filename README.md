# Poorman's VPN
Poorman's VPN is a project with scripts to help you redirect your internet traffic through an SSH Tunnel


## Windows

To use on Windows download the [`tunnel.bat`](https://github.com/sepgh/poormans-vpn/blob/main/tunnel.bat) file and move it to the folder of your choice. Then run by double clicking on it.

In first run you need to use option `0` to download `plink.exe` (which is used for Putty). You can [check the checksum here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).
If you don't want to download the `plink.exe` through the script then manually download it and place it right next to `tunnel.bat`

Then you can use option `1` to connect to SSH server. There will be a socks port available on port `6060` when the connection is made.
Your system will be configured to move the traffic to `SOCKS:localhost:6060` through Windows Registry.

To close the connection you can try `control + D` and then `control + C` if needed.

**Tested on**: Windows 10
