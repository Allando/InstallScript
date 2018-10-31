#!/bin/bash

set -e

verifyDistro()
{
    currentDistro=$(lsb_release -si)

    case currentDistro in
        "ManjaroLinux"  ):  currentDistro="manjaro";;
        "ArchLinux"     ):  currentDistro="arch";;
        "ubuntu"        ):  currentDistro="ubuntu";;
        "kali"          ):  currentDistro="kali";;
        * 				):  echo "System not supported" && (exit 1);
    esac

    return currentDistro
}

installSystemDependentStuff()
{
    distro=$(verifyDistro)

    case currentDistro in
        "manjaro"   ):  $(sudo arch/manjaro.sh);;
        "arch"      ):  $(sudo arch/arch.sh);;
        "ubuntu"    ):  $(sudo debian/ubuntu.sh);;
        "kali"      ):  $(sudo debian/kali.sh);;
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
    echo Creating directories

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
}

Dotfiles()
{
    cd /home/$USER/ComputerScience/Programming/Repositories
    git clone https://github.com/allando/Dotfiles.git

    # Installing pathogen
    sh /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Vimrc/install.sh

    cd # Back to home

    # Symbolic links
    ln -s /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Vimrc/vimrc .vimrc

    sudo rm -r .bashrc
    ln -s /home/$USER/ComputerScience/Programming/Repositories/Dotfiles/Bashrc/bashrc .bashrc 
}

main()
{
    if [[ $(verifyDistro) != "kali" -o $(verfyDistro) != "arch" ]]; then
        creatingDirectories
        Dotfiles
        installSystemDependentStuff
        setUpSystems
  	else
  		installSystemDependentStuff
    fi

    cowsay "All done! Systems ready" | lolcat -a
}

main