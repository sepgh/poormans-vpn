# Poorman's VPN
Poorman's VPN is a project with scripts to help you redirect your internet traffic through an SSH Tunnel.

Check out the successor project, [Mooshak](https://github.com/sepgh/mooshak), with websocket support and better documentations.

---

Ever cried about having to use Putty to setup Dynamic Port Forwarding through SSH Tunnel? Ever been bothered by paid softwares that don't do all of the job right? No? Good! Yes? Well I have found a new reason for you to cry. Read the description below to setup a client if you already have a server with SSH access (no root required), or read server section to get some clues on how to run a SSH server.


<details>
<summary><h2>server</h2></summary>

## Introduction

I think the description of the repository is pretty self explanatory and any one with basic knowledge of .... ok f*** it, let me explain it to you.

So, SSH is a secure way of accessing your linux machine shell. You have probably seen Putty or simple `ssh` commands if you have ever connected to any linux machines out there through shell.

What you can do with your SSH connection is to also route your computer network traffic to it and thats what this script will achieve. It will use **Dyanmic Port Forwarding** from an established SSH connection.

## Solution one:

You can use pretty much any linux machine with SSH server and user to log in as a tunnel for your network traffic. So, basic requirement is to simply create a linux user. You can search for ways to do so, but here is a basic example of what you can do in order to create a new user in your linux machine (assuming you already have `root/sudo` access to shell)

```bash
ln -s /bin/bash /bin/rbash
mkdir /home/peter
useradd -s /bin/rbash -d /home/peter peter
passwrd peter
```

The snippet above creates a user with no access to bash (probably the default shell of your linux machine) and sets a password for it. Replace `peter` with username of your choice.

You are done.

## Solution two:

Use my [poorly written sshd server tool](https://github.com/sepgh/poormans-vpn-sshd-server).

## Solution three:

Use [Mooshak](https://github.com/sepgh/mooshak) server.

</details>

<details>
<summary><h2>Client</h2></summary>

## Mac/Linux

I respect you guys for using Linux (Mac? Meeh!). My suggestion to you is to install `python 3.7+` on your servers, allow the user to have access to that command and then forget anything this repository says and checkout [sshuttle](https://sshuttle.readthedocs.io/en/stable/). **This does not work with solution two of the server side**

I find the command below to be the most effective solution on linux machine, but read the documentations from sshuttle for more details.

```bash
sshuttle --dns -r user@ip:port 0.0.0.0/0 --method nft --no-latency-control
```

I have created this repository to help our poor friends which are using windows.

## Android

Use [SSH Injector](https://play.google.com/store/apps/details?id=com.technore.sshinjector&hl=en&gl=US&pli=1). For further explanation refer to your brain honey. But you will pretty much need ip, port, username and password.

## Windows

### Solution 1

This repository so far is only about these two scripts: [`tunnel.bat`](https://github.com/sepgh/poormans-vpn/blob/main/tunnel.bat) (Which is the script that we should run, aka our entry point)  & [`ssh-alive.bat`](https://github.com/sepgh/poormans-vpn/blob/main/ssh-alive.bat)

What it does:

1. creates SSH Tunnel and opens dynamic socks port `6060` on your machine
2. runs a DNS server (DNS Over Socks) which is ... well, obviously, DNS over Socks :|
3. change windows proxy settings to use socks proxy that was created on step 1
4. changes your network interface DNS settings to use DNS server that was created on step 2
5. using `ssh-alive.bat` we will try to keep the SSH connection alive

Running it is easy. I suggest you to download the zip package with all dependencies from [release section](https://github.com/sepgh/poormans-vpn/releases/tag/v2.1.0). Or just download `tunnel.bat` file from the repository. In either case, move the content you downloaded into a specific folder of your choice and if you downloaded the zip file, extract it.

Then right click on tunnel.bat and **run it as administrator**. The script will give you some choices:

- `0` download dependencies (you already have them if you downloaded zip file)
- `1` connect
- `2` disconnect

The rest is straight forward. After connecting you can feel free to close the main window (tunnel.bat)

**Notes:**

1. Closing windows of the applications (TUNNEL and DNS) is not enough for full disconnect. You need to run `tunnel.bat` as an administrator again and choose second option to disconnect.
2. `DNSToSocks` has a bug that if you select something or click on its screen it will freeze and will F things up. Don't do it.

**Requirements details:**

This script requires two more windws executable files:

1. `plink.exe`, used in Putty, adds ssh and tunneling support (in case windows misses it).
You can [check the checksum here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
2. [`dns2socks.exe`](https://sourceforge.net/projects/dns2socks/), because we need DNS requests to also be proxied.

The zip file from releases has both of these already so you wont need to do anything. You can download them manually and place them next to `tunnel.bat` if you need. Otherwise you can use option `0` so the script download these for you.

**Tested on**: Windows 10


### Solution 2

Use [Mooshak](https://sepgh.github.io/mooshak/docs/clients/windows/). Currently Mooshak is just python wrapper of the batch script above.

---

That's all. **F windows** dude! Bye!

</details>

---

If you enjoy this project consider `star` and share.

