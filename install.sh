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
        * 				):  echo "System not supported" && (exit 1);
    esac

    notificationColor "success" 'Done'
    return currentDistroS
}

installSystemDependentStuff()
{
    case $1 in
        "manjaro"   ):  $manjaroSetUp;;
        "arch"      ):  $archSetUp;;
        "ubuntu"    ):  $ubuntuSetUp;;
        "kali"      ):  $kaliSetUp;;
        * 			):  echo "Still not supported... How the hell did this slip through" && (exit 1);
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
    sudo echo GRUB_BACKGROUND="/sr/share/grub/RuinerBooting.jpg" >> $pathToGrub

    sudo systemctl enable ufw

	# TODO: Cronjob: Prepare auto update for clamav
}

creatingDirectories()
{
    notificationColor "normal" "Creating directories..."

    mkdir -v -p \
    	/home/$USER/ComputerScience \
    	/home/$USER/ComputerScience/Programming \
        /home/$USER/ComputerScience/Programming/Assembly \
        /home/$USER/ComputerScience/Programming/Assembly/LearnAssembly \
        /home/$USER/ComputerScience/Programming/Assembly/Repositories \
        /home/$USER/ComputerScience/Programming/Bash \
        /home/$USER/ComputerScience/Programming/Bash/LocalScript \
        /home/$USER/ComputerScience/Programming/Bash/Repositories \
        /home/$USER/ComputerScience/Programming/C \
        /home/$USER/ComputerScience/Programming/C/FunC \
        /home/$USER/ComputerScience/Programming/C/LearnC \
        /home/$USER/ComputerScience/Programming/C/Repositories \
        /home/$USER/ComputerScience/Programming/JavaScript \
        /home/$USER/ComputerScience/Programming/JavaScript/Repositories \
        /home/$USER/ComputerScience/Programming/Python \
        /home/$USER/ComputerScience/Programming/Python/FunPy \
        /home/$USER/ComputerScience/Programming/Python/LearnPy \
        /home/$USER/ComputerScience/Programming/Python/Repositories \
        /home/$USER/ComputerScience/Programming/Repositories \
        /home/$USER/ComputerScience/Programming/Sharp \
        /home/$USER/ComputerScience/Programming/Repositories \
    	/home/$USER/ComputerScience/ReverseEngineering \
        /home/$USER/ComputerScience/ReverseEngineering/FunAndCrackMe \
        /home/$USER/ComputerScience/ReverseEngineering/Literatur \
        /home/$USER/ComputerScience/ReverseEngineering/Tools

    notificationColor "success" "Done"
}

Dotfiles()
{
	notificationColor "normal" "Setting up dotfiles"
    cd /home/$USER/ComputerScience/Programming/Repositories
    git clone https://github.com/allando/Dotfiles.git

    # Installing pathogen
    sh /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Vimrc/install.sh

    cd # Back to home

    # Symbolic links
    ln -s /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Vimrc/vimrc .vimrc

    sudo rm -r .bashrc
    ln -s /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Bashrc/bashrc .bashrc
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
		yaourt \
}

manjaroSetUp()
{
	notificationColor "normal" "Installing applications..."

	installPacman="sudo pacman -S --noconfirm"

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
        termite \
        vim \
        virtualbox \
        wireshark-qt \
        yaourt \

	# Radare 2 from reposetories
	cd /home/$USER/ComputerScience/ReverseEngineering/Tools
	git clone https://github.com/radare/radare2.git
	sudo sh radare2/sys/install.sh

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
		wireshark \

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
		wireshark \

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
		CTF/HackTheBox \
		CTF/OverTheWire \
		CTF/Ŕoot-Me \
		Scripts/Repositories\
		Scripts/LocalScripts

	notificationColor "success " "Done"
	
	### Directories end ###

	### Installing stuff ###
	sysDir="SystemStuff/Repositories/"

	notificationColor "normal" "Installing from reposetories..."
	echo $(tput setaf 6)'Cloning Repositories'$(tput sgr0)
	
	#Allando Repositories
	$clone https://github.com/allando/Dotfiles.git ~/SystemStuff/Repositories/

	#Creating Symbolic links
	$symbolic SystemStuff/Repositories/Vimrc/vimrc ~/.vimrc

	# peda-gdp
	git clone https://github.com/longld/peda.git ~/peda
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
	distro=$verifyDistro

 	if [[ $distro != "kali" -o $distro != "arch" ]]; then
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