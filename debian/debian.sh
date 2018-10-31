#!/bin/bash

set -e

#I am lazy.

install="sudo apt-get -y install" 
remove="sudo apt -y --purge remove"  
symbolic="ln -s"
clone="git clone"

main()
{
 	PreparingSystems
 	Installing
	Uninstalling
}

PreparingSystems()
{
	echo $(tput setaf 6)'Preparing Systems!'$(tput sgr0)
	
	su
	apt-get install sudo
	group add ($user)
	back
	
}

Installing()
{
	echo $(tput setaf 6)'Installing'$(tput sgr0)
	
	$install build-essential \
			clamav \
			cowsay \
			git \
			htop \
			lolcat \
			nload \
			nmap \
			oneko \
			pm-utils \
			vim \
			vlc \
			virtualbox \
			wireshark \

	echo $(tput setaf 2)'Installing complete!'$(tput sgr0)
}

Uninstalling()
{
	# if gnome then remve this
	echo $(tput setaf 6)'Uninstalling'$(tput sgr0)

	#Media
	$remove brasero brasero-cdrkit brasero-common gnome-music rhythmbox

	#Games
	$remove gnome-mahjongg gnome-mines gnome-sudoku

	if [[ $(lsb_release -si) = "Debian" ]]; then
		$remove gnome-chess four-in-a-row five-or-more hitori lagno gnome-klotski lightsoff gnome-nibbles gnome-robots quadrapassel swell-foop tali gnome-taquin gnome-tetravex
	fi

	if [[ $(lsb_release -si) = "Ubuntu" ]]; then
		$remove aisleriot
	fi

	#Common
	$remove gnome-maps gnome-weather

	echo $(tput setaf 2)'Uninstalling complete!'$(tput sgr0)
}

main
