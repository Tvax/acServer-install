#!/bin/bash

steamcmd(){
	sudo apt-get install lib32gcc1;
	sudo apt-get install curl;
	mkdir ~/Steam && cd ~/Steam;
	curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
}

acDownload(){
	echo "Steam need to check if you own the game before downloading the files.";
	echo "Neither of your username and password will be saved !";
	echo "Enter your Steam username : ";
	read username;
	echo "Enter your Steam password: ";
	read password;

	read -e -p "Path to download Assetto Corsa's server files : " -i "$HOME/AC" directory;
	mkdir -p "$directory";
	./steamcmd.sh +@sSteamCmdForcePlatformType windows +login $username $password +force_install_dir $PATH +app_update 302550 +quit
}

##Check if system compatible before install
compatible(){
	##Check if distribution is supported
	if [[ -z "$(uname -a | grep Ubuntu)" && -z "$(uname -a | grep Debian)" ]];then
		return 1
	fi
}

##Updates && Upgrades
updates(){
	echo "Installing updates !"
	sudo apt-get update;
	sudo apt-get upgrade;
}

main(){
	##call compatible to check if distro is either Debian or Ubuntu
	compatible
	if [ $? == 1 ]; then
		echo Distro not supported
		exit 1
	fi
	##call updates to upgrade the system
	updates
	steamcmd
	acDownload
}

main

echo "Successfully downloaded !";