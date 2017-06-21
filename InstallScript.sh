#!/bin/bash

set -e

#I am lazy.



install="sudo apt-get -y install" 
remove="sudo apt -y --purge remove"  
symbolic="ln -s"
clone="git clone"

main()
{
	VerifyDistro
 	PreparingSystems
 	Installing
	Uninstalling
	AutoRemove

	cowsay "ALL DONE!!!" | lolcat -a
}

# This function verifies which distro it's being used on
# If distro is Debian, will the function download sudo.
VerifyDistro()
{
	if [[ $(lsb_release -si) = "Debian" ]]; then
		su
		apt-get install sudo
		group add ($user)
		back
	fi
}

PreparingSystems()
{
	echo $(tput setaf 6)'Preparing Systems!'$(tput sgr0)
	
	CreatingDirectories
	Repositories

	#Running updateScript
	sh Programming/Shell/Repos/updateScript/updateScript.sh

	#Creating Symbolic links
	$symbolic Programming/Repos/Vimrc/vimrc ~/.vimrc
			
	echo $(tput setaf 2)'Preparation Complete!'$(tput sgr0)
}

CreatingDirectories()
{
	echo $(tput setaf 6)'Creating Directories'$(tput sgr0)

	#Programming directories
	mkdir ~/Programming

	mkdir ~/Programming/Repos

	mkdir ~/Programming/Shell
	mkdir Programming/Shell/Repos
	echo $(tput setaf 2)'Done!'$(tput sgr0)
}

Repositories()
{
	echo $(tput setaf 6)'Cloning Repositories'$(tput sgr0)

	$install git
	
	#Allando Repositories
	$clone https://github.com/allando/updatescript.git ~/Programming/Shell/Repos/
	$clone https://github.com/allando/vimrc.git ~/Programming/Repos/

	#radare2
	$clone https://github.com/radare/radare2.git ~/Programming/Repos/radare2
	echo $(tput setaf 2)'Done!'$(tput sgr0)
}



Installing()
{
	echo $(tput setaf 6)'Installing'$(tput sgr0)
	
	#Programming application
	$install build-essential git vim

	sh Programming/Repos/radare2/sys/install.sh 

	#Networking tools
	$install wireshark nmap nload

	#System tools
	$install htop pm-utils clamav

	#Mediai
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
