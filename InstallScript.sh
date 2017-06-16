#!/bin/bash

set -e

install="sudo apt-get -y install" 
remove="sudo apt -y --purge remove"  

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

	$install git
	mkdir ~/Programming
	mkdir ~/Programming/Shell
	mkdir Programming/Shell/Repos
	git clone https://github.com/allando/updatescript.sh ~/ProgrammingShell/Repos/
	
	sh ~/Programming/Shell/Repos/updatescript/updatescript.sh

	echo $(tput setaf 2)'Preparation Complete!'$(tput sgr0)
}

Installing()
{
	echo $(tput setaf 6)'Installing'$(tput sgr0)
	#Programming application
	$install build-essential git vim

	#Networking tools
	$install wireshark nmap nload

	#System tools
	$install htop pm-utils clamav

	#Media
	$install clementine vlc

	#Misc applications
	$install virtualbox

	#for the lolz
	$install lolcat oneko cowsay
	echo $(tput setaf 2)'Installing complete!'$(tput sgr0)
}

Uninstalling()
{
	echo $(tput setaf 6)'Uninstalling'$(tput sgr0)

	#Media
	$remove brasero brasero-cdrkit brasero-common gnome-music rhythmbox

	#Games
	$remove gnome-mahjongg gnome-mines gnome-sudoku aisleriot

	#Common
	$remove gnome-maps gnome-weather
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
