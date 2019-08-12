#!/bin/bash

set -e

verifyDistro()
{
	notificationColor "normal" "Verifying distro"

	currentDistro=$(lsb_release -si)

	case currentDistro in
		"ManjaroLinux"  ):  currentDistro="manjaro";;
		"ArchLinux"     ):  currentDistro="arch";;
		"ubuntu"        ):  currentDistro="ubuntu";;
		"kali"          ):  currentDistro="kali";;
		* 				):  error "System not supported" && (exit 1);
	esac

	notificationColor "success" 'Done'
	return currentDistro
}

installSystemDependentStuff()
{
	case $1 in
		"manjaro"   ):  $manjaroSetUp;;
		"arch"      ):  $archSetUp;;
		"ubuntu"    ):  $ubuntuSetUp;;
		"kali"      ):  $kaliSetUp;;
		* 			):  error "Still not supported... How the hell did this slip through" && (exit 1);
	esac
}

# Bootloader stuff
setUpSystems()
{
	pathToGrub = "/usr/default/grub"

	tar -xvf libs/img.tar
	sudo cp libs/RuinerBooting.jpg /usr/share/grub/RuinerBooting.jpg
	sudo echo GRUB_COLOR_NORMAÆ="red/black" >> $pathToGrub
	sudo echo GRUB_COLOR_HIGHLIGHT="black/red" >> $pathToGrub
	sudo echo GRUB_BACKGROUND="/usr/share/grub/RuinerBooting.jpg" >> $pathToGrub

	sudo systemctl enable ufw

	# TODO: Cronjob: Prepare auto update for clamav
}

creatingDirectories()
{
	notificationColor "normal" "Creating directories..."

	mkdir -v -p \
		/home/$USER/.SystemFiles \
		/home/$USER/Projects \
		/home/$USER/Projects/Programming \
		/home/$USER/Projects/Programming/Assembly \
		/home/$USER/Projects/Programming/Assembly/LearnAssembly \
		/home/$USER/Projects/Programming/Assembly/Repositories \
		/home/$USER/Projects/Programming/Bash \
		/home/$USER/Projects/Programming/Bash/Repositories \
		/home/$USER/Projects/Programming/C \
		/home/$USER/Projects/Programming/C/FunC \
		/home/$USER/Projects/Programming/C/LearnC \
		/home/$USER/Projects/Programming/C/Repositories \
		/home/$USER/Projects/Programming/Python \
		/home/$USER/Projects/Programming/Python/FunPy \
		/home/$USER/Projects/Programming/Python/LearnPy \
		/home/$USER/Projects/Programming/Python/Repositories \
		/home/$USER/Projects/Programming/Repositories \
		/home/$USER/Projects/Programming/Sharp \
		/home/$USER/Projects/Programming/Repositories \


	notificationColor "success" "Done"
}

Dotfiles()
{
	notificationColor "normal" "Setting up dotfiles"
	cd /home/$USER/Projects/Programming/Repositories
	git clone https://github.com/allando/Dotfiles.git

	# Installing pathogen
	sh /home/$USER/Projects/Programming/Repositories/Dotfiles/Vimrc/install.sh

	cd # Back to home

	# Symbolic links
	ln -s /home/$USER/.SystemFiles/Dotfiles/Vimrc/vimrc /$USER/.vimrc

	sudo rm -rfv .bashrc
	ln -s /home/$USER/.SystemFiles/Dotfiles/Bashrc/bashrc /$USER/.bashrc
	notificationColor "success" "Done"
}

archSetUp()
{
	notificationColor "fail" "Not ready"

	$install \
		base-devel \
		byobu \
		calcurse \
		comsay \
		dnsutils \
		gtop \
		htop \
		gnu-netcat \
		linux414-virtualbox-host-modules \
		lolcat \
		nmap \
		termite \
		vim \
		virtualbox \
		wireshark-qt \
		yaourt/
}

manjaroSetUp()
{
	notificationColor "normal" "Installing applications..."

	installPacman="sudo pacman -S --noconfirm"
	installTrizen="trizen -S"

	### System tools
	$installPacman \
		base-devel \
		byobu \
		calcurse \
		comsay \
		dnsutils \
		gtop \
		htop \
		gnu-netcat \
		linux414-virtualbox-host-modules \
		lolcat \
		nmap \
		numlockx \
		qbittorrent \
		termite \
		trizen \
		vim \
		virtualbox \
		wireshark-qt \

	# PIA OpenVpn
	cd .SystemFiles	
	wget  https://www.privateinternetaccess.com/installer/pia-nm.sh
	sudo sh pia-nm.sh
	cd /home/$ŨSER/

	# SublimeText 3
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

	$installTrizen\
		spotify \
		telegram-desktop \
		tor-browser \




	notificationColor "success" "Done"
}

debianSetUp()
{
	notificationColor "fail" "Not ready"

	notificationColor "normal" "Installing applications..."

	$install \
		build-essential \
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
		wireshark

	notificationColor "success" "Done"
}

ubuntuSetUp()
{
	notificationColor "normal" "Installing applications..."

	installApt=$("sudo apt install -y")

	#Programming application
	$installApt \
		build-essential \
		clamav \
		cowsay \
		htop \
		lolcat \
		nload \
		nmap \
		oneko \
		pm-utils \
		vim \
		vlc \
		virtualbox \
		wireshark

	notificationColor "success" "Done"
}

kaliSetUp()
{
	install="sudo apt-get -y install" 
	remove="sudo apt -y --purge remove"  
	symbolic="ln -s"
	clone="git clone"

	notificationColor "normal" "Preparing systems..."

	#Running updateScript
	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade
	apt -y autoremove

	notificationColor "success" "Done"

	### Directories ###
	notificationColor "normal" "Creating Directories..."

	mkdir -v -p \
		/root/CTF/HackTheBox \
		/root/CTF/OverTheWire \
		/root/CTF/Ŕoot-Me \
		/root/Scripts/Repositories\
		/root/Scripts/LocalScripts

	notificationColor "success " "Done"
	
	### Directories end ###

	### Installing stuff ###
	sysDir="SystemStuff/Repositories/"

	notificationColor "normal" "Installing from reposetories..."
	echo $(tput setaf 6)'Cloning Repositories'$(tput sgr0)
	
	#Allando Repositories
	$clone https://github.com/allando/Dotfiles.git /root/SystemStuff/Repositories/

	#Creating Symbolic links
	$symbolic SystemStuff/Repositories/Vimrc/vimrc /root/.vimrc

	# peda-gdp
	git clone https://github.com/longld/peda.git /root/peda
	echo "source ~/peda/peda.py" >> ~/.gdbinit
	echo "DONE! debug your program with gdb and enjoy"

	notificationColor "success" "Done"

	notificationColor "normal" "Installing applications..."
	
	$install cowsay lolcat

	notificationColor "success" "Done"
	
	### Installing stuff end ###
}

notificationColor()
{ 
	chosenColor=403

	case $1 in
		'fail'		) chosenColor=9;;
		'normal' 	) chosenColor=255;;
		'success' 	) chosenColor=10;;
		*			) chosenColor=404;;
	esac

	echo $(tput setaf $chosenColor) '[*]' $2 $(tput sgr0)
}

main()
{
	if [[ $(whoami) == "root" ]]; then
		echo "Do not run the whole script as root."
		exit(1)
	fi

	distro=$verifyDistro
	echo $distro

	if [[ $distro != "kali" && $distro != "arch" ]]; then
		creatingDirectories
		Dotfiles
		installSystemDependentStuff $distro
		setUpSystems
	else
		installSystemDependentStuff $distro
	fi

	cowsay "All done! Systems ready" | lolcat -a
}

main
