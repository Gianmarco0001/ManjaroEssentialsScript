#!/bin/bash
# This script is created by GBytez.
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
cat << "EOF"


░██████╗░██████╗░██╗░░░██╗████████╗███████╗███████╗
██╔════╝░██╔══██╗╚██╗░██╔╝╚══██╔══╝██╔════╝╚════██║
██║░░██╗░██████╦╝░╚████╔╝░░░░██║░░░█████╗░░░░███╔═╝
██║░░╚██╗██╔══██╗░░╚██╔╝░░░░░██║░░░██╔══╝░░██╔══╝░░
╚██████╔╝██████╦╝░░░██║░░░░░░██║░░░███████╗███████╗
░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚══════╝
                                                                    
******************************************************************************************************************
___  ___            _                   _____                   _   _       _       _____           _       _    *
|  \/  |           (_)                 |  ___|                 | | (_)     | |     /  ___|         (_)     | |   *
| .  . | __ _ _ __  _  __ _ _ __ ___   | |__ ___ ___  ___ _ __ | |_ _  __ _| |___  \ `--.  ___ _ __ _ _ __ | |_  *
| |\/| |/ _` | '_ \| |/ _` | '__/ _ \  |  __/ __/ __|/ _ \ '_ \| __| |/ _` | / __|  `--. \/ __| '__| | '_ \| __| *
| |  | | (_| | | | | | (_| | | | (_) | | |__\__ \__ \  __/ | | | |_| | (_| | \__ \ /\__/ / (__| |  | | |_) | |_  *
\_|  |_/\__,_|_| |_| |\__,_|_|  \___/  \____/___/___/\___|_| |_|\__|_|\__,_|_|___/ \____/ \___|_|  |_| .__/ \__| *
                  _/ |                                                                               | |         *
                 |__/                                                                                |_|         *
******************************************************************************************************************


EOF
echo -e "${LIGHTGREEN}Looking for the fastest mirror, please wait! (CTRL-C to stop it)${NOCOLOR}"
sudo pacman-mirrors --fasttrack
sudo pacman -Sy
sudo pacman -Syu
sudo pacman -Syuu
echo -e "${LIGHTGREEN}Installing some essentials stuff... it will take a while...${NOCOLOR}"
sudo pacman -Sy base-devel
sudo pacman -S libcurl4-openssl-dev
sudo pacman -S libssl-dev
sudo pacman -S python-setuptools
sudo pacman -S python3-pip
sudo pacman -S python-pip
sudo pacman -S git
sudo pacman -S wine


echo -e "${LIGHTGREEN}Now installing Java stuff...${NOCOLOR}"

sudo pacman -sS java | grep jre
sudo pacman -S jre-openjdk
sudo pacman -sS java | grep jdk
sudo pacman -S jdk-openjdk

echo -e "${LIGHTGREEN}Java stuff installed!${NOCOLOR}"

#Silos install

echo -e "${LIGHTGREEN}Installing Silos Web app container...${NOCOLOR}"

git clone https://aur.archlinux.org/silos.git
cd silos
makepkg -sci
cd ..

echo -e "${LIGHTGREEN}Done!${NOCOLOR}"

# Snapd install

echo -e "${LIGHTGREEN}Creating a new dir and installing snapd...${NOCOLOR}"

mkdir ~/manjaro_script_tools
cd ~/manjaro_script_tools/
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -sci
cd ~/manjaro_script_tools/
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap


#Install Microsoft Teams
echo -e -n "\033[1;32mIf you are a student maybe you need Microsoft Teams (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  git clone https://aur.archlinux.org/teams.git
  cd teams 
  makepkg -sci
  cd ~/manjaro_script_tools/
  echo  -e "${LIGHTGREEN}Done! Teams is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install NordVPN CLI Version
echo -e -n "\033[1;32mYo mate, do you need NordVPN for extra protection? (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  git clone https://aur.archlinux.org/nordvpn-bin.git
  cd nordvpn-bin
  echo -e "${LIGHTGREEN}What is your system username?:${NOCOLOR} "
  read first_name
  echo -e "${LIGHTGREEN}So you are $first_name , ok thanks, now we can install NordVPN${NOCOLOR}" 
  sudo groupadd -r nordvpn
  makepkg -sci
  sudo gpasswd -a $first_name nordvpn
  sudo systemctl enable --now nordvpnd
  cd ~/manjaro_script_tools/
  systemctl enable nordvpnd.service
  systemctl start nordvpnd.service
  echo -e "${LIGHTGREEN}Done! NordVPN is ready${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install Balena Etcher

echo -e -n "\033[1;32mNow is time for Balena Etcher, this program will allow you to flash OS images to flash drives and sd cards quickly and safely.. Do you want it?  (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  git clone https://aur.archlinux.org/etcher-bin.git
  cd etcher-bin
  makepkg -sci
  sudo chmod 4755 /opt/balenaEtcher/chrome-sandbox
  cd ~/manjaro_script_tools/
  echo -e "${LIGHTGREEN}Done! Balena Etcher is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install PlayOnLinux

echo -e -n "\033[1;32mI have this very useful tool to offer youm PlayOnLinux. It will allow you to install some applications present in the Windows environment. (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  sudo pacman -S playonlinux
  echo -e "${LIGHTGREEN}Done! Balena Etcher is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install Visual Studio Code

echo -e -n "\033[1;32m If you are a programmer, I have this program for you, Visual Studio Code. Do you need it?  (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  git clone https://aur.archlinux.org/visual-studio-code-bin.git
  cd visual-studio-code-bin
  makepkg -sci
  cd ~/manjaro_script_tools/
  echo -e "${LIGHTGREEN}Done! Visual Studio Code is ready for you!${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi


#Install Discord

echo -e -n "\033[1;32mIf you are a gamer you will probably need discord (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  sudo snap install discord
  echo -e "${LIGHTGREEN}Done! Discord is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install Spotify

echo -e -n "\033[1;32mI love music and you? I have the Spotify app for you (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  sudo snap install spotify
  echo -e "${LIGHTGREEN}Done! Spotify is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install GeForce Now

echo -e -n "\033[1;32mHey gamer, do you need GeForce Now? (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}let's install it then${NOCOLOR}";
  sudo snap install geforcenow
  echo -e "${LIGHTGREEN}Done! Discord is ready for you${NOCOLOR}"
else
  echo -e "${LIGHTBLUE}Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

	
#Install adobe acrobat pdf reader

echo -e -n "\033[1;32mDo you need a PDF Reader? (y/n)"
echo -e -n '\e[0;0m'
read CONT
if [ "$CONT" = "y" ]; then
	echo -e "${LIGHTGREEN}let's install Adobe Acrobat then${NOCOLOR}";
	git clone https://aur.archlinux.org/acroread.git
	cd acroread
	makepkg -sci
	cd ~/manjaro_script_tools/
	echo -e "${LIGHTGREEN}Done! Adobe Acrobat is ready for you${NOCOLOR}"
else
	echo -e "${LIGHTBLUE} Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi
#Install Telegram Desktop

echo -e -n "\033[1;32mDo you need a Telegram Desktop? (one of the most popular messaging apps) (y/n)"
echo -e -n '\e[0;0m'
read CONT 
if [ "$CONT" = "y" ]; then
	echo -e "${LIGHTGREEN}let's install Telegram Desktop${NOCOLOR}";
	sudo snap install telegram-desktop
	echo -e "${LIGHTGREEN}Done! Telegram is ready for you${NOCOLOR}"
else
	echo -e "${LIGHTBLUE} Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi

#Install Whatsapp Desktop

echo -e -n "\033[1;32mDo you need a Whatsapp Desktop? (one of the most popular messaging apps) (y/n)"
echo -e -n '\e[0;0m'
read CONT 
if [ "$CONT" = "y" ]; then
	echo -e "let's install Whatsapp Desktop${NOCOLOR}";
	git clone https://aur.archlinux.org/whatsapp-for-linux.git
	cd whatsapp-for-linux
	makepkg -sci
	cd ~/manjaro_script_tools/
	echo -e "${LIGHTGREEN}Done! Whatsapp is ready for you${NOCOLOR}"
else
	echo -e "${LIGHTBLUE} Oh ok no problem, I have other interesting stuff for you!${NOCOLOR}";
fi
# End

echo -e "${RED}DONE!! This is the end of the script, please reboot the system!${NOCOLOR}"

echo -e "${LIGHTGREEN}But first, let's do a quick update...${NOCOLOR}"
sudo pacman -Sy && sudo pacman -Syu && sudo pacman -Syuu
echo -e "${LIGHTRED}This Script is made by ----------------MrCodeBlocks-----------------${NOCOLOR}"
echo -e "${LIGHTRED}Check also this site https://archlinux.org/ for other apps${NOCOLOR}"
echo -e "${LIGHTRED}Put also a Star on my GitHub Project and share it! Thanks!${NOCOLOR}"

#Time for reboot and cheers

echo -e -n "\033[1;32mReboot the system now? (y/n)"
echo -e -n '\e[0;0m'
read CONT 
if [ "$CONT" = "y" ]; then
  echo -e "${LIGHTGREEN}Ok thanks!${NOCOLOR}";
  echo -e "${LIGHTGREEN}See Ya${NOCOLOR}"
  sudo reboot 0
  else
  echo -e "${LIGHTGREEN}Oh ok no problem, Reboot it later${NOCOLOR}";
fi











