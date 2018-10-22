#!/bin/bash

set -e

main()
{
 	PreparingSystems
 	Installing
	Uninstalling
	AutoRemove

	cowsay "ALL DONE!!!" | lolcat -a
}

PreparingSystems()
{
	echo $(tput setaf 6)'Preparing Systems!'$(tput sgr0)

	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade

	echo $(tput setaf 2)'update complete'$(tput sgr0)
}

Installing()
{
	echo $(tput setaf 6)'Installing'$(tput sgr0)
	#Programming application
	sudo apt-get -y install build-essential git vim

	#Networking tools
	sudo apt-get -y install wireshark nmap nload

	#System tools
	sudo apt-get -y install htop pm-utils

	#Media
	sudo apt-get -y install clementine vlc

	#for the lolz
	sudo apt-get -y install lolcat oneko cowsay
	echo $(tput setaf 2)'Installing complete!'$(tput sgr0)
}

Uninstalling()
{
	echo $(tput setaf 6)'Uninstalling'$(tput sgr0)

	#Media
	sudo apt-get -y --purge remove brasero brasero-cdrkit brasero-common gnome-music rhythmbox

	#Games
	sudo apt-get -y --purge remove gnome-mahjongg gnome-mines gnome-sudoku aisleriot

	#Common
	sudo apt-get -y --purge remove gnome-maps gnome-weather
	echo $(tput setaf 2)'Uninstalling complete!'$(tput sgr0)
}

AutoRemove()
{
	echo $(tput setaf 6)'Auto Removing'$(tput sgr0)

	if (sudo apt -y autoremove); then echo $(tput setaf 2)'Auto removing complete'$(tput sgr0)
	else echo $(tput setaf 2)'No need for autoremoving'$(tput sgr0)
	fi
}

main
