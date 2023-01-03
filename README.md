# Poorman's VPN
Poorman's VPN is a project with scripts to help you redirect your internet traffic through an SSH Tunnel


## Windows

### Through [`tunnel.bat`](https://github.com/sepgh/poormans-vpn/blob/main/tunnel.bat)

To create tunnel on Windows, download the [`tunnel.bat`](https://github.com/sepgh/poormans-vpn/blob/main/tunnel.bat) file and move it to the folder of your choice. Then run by double clicking on it.

This script requires two more windws executable files:

1. `plink.exe`, used in Putty, adds ssh and tunneling support (in case windows misses it).
You can [check the checksum here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), download it manually if you want or let the script download it for you.
2. [`dns2socks.exe`](https://sourceforge.net/projects/dns2socks/), because we need DNS requests to also be proxied.

If you download any of the above dependencies yourself, place them next to `tunnel.bat` file. You can download the full package (`tunnel.bat` and all the dependencies) from the [release](https://github.com/sepgh/poormans-vpn/releases/tag/v1.0.0).

Eventually, **run `tunnel.bat` as administrator**. If you don't have the dependencies downloaded, use option `0` and the script will try to download it for you.

Then you can use option `1` to connect to SSH server. There will be a socks port available on port `6060` when the connection is made.
Your system will be configured to move the traffic to `SOCKS:localhost:6060` through __Windows Registry__, and send DNS traffic to `dns2socks` through network interface.

You can exit the main batchfile window if you want. To successfully disconnect you need to use option 2 in batch file.


**Tested on**: Windows 10
