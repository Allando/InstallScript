#!/bin/bash

set -e

main()
{
    Update
    CreateDirectories
    InstallShit
    Dotfiles

    cowsay "ALL FUCKING DONE!!!" | lolcat -a
}

Update()
{
    echo Updating...

    if (sudo pacman -Syyu); then
        echo Update complete
    else
        echo Update failed
    fi
}

CreateDirectories()
{
    echo Creating directories

    # Changing current directory to home
    cd 

    # Computer science
    mkdir -v ComputerScience
    cd ComputerScience

    # Programming
    mkdir -v -p Programming \
        Programming/Assembly \
        Programming/Assembly/LearnAssembly \
        Programming/Assembly/Repositories \
        Programming/Bash \
        Programming/Bash/LocalScript \
        Programming/Bash/Repositories \
        Programming/C \
        Programming/C/FunC \
        Programming/C/LearnC \
        Programming/C/Repositories \
        Programming/JavaScript \
        Programming/JavaScript/Repositories \
        Programming/Python \
        Programming/Python/FunPy \
        Programming/Python/LearnPy \
        Programming/Python/Repositories \
        Programming/Repositories \
        Programming/Sharp \
        Programming/Repositories
    
    # Reverse Engineering
    mkdir -v -p ReverseEngineering \
        ReverseEngineering/FunAndCrackMe \
        ReverseEngineering/Literatur \
        ReverseEngineering/Tools
		
    #Returning to home
    cd 
}

InstallShit()
{
    echo Installing stuffs
    
    INSTALL="sudo pacman -S --noconfirm"

    ### System tools
    $INSTALL yaourt htop gtop

    ### Programming
    $INSTALL vim base-devel

    ### Applications
    ## Virtualbox
    $INSTALL linux414-virtualbox-host-modules virtualbox
		
    ##Terminal
    $INSTALL termite
    
    ## Screen
    $INSTALL screen

    ### Reverse Engineering Tools
    ## Repositories

    #Radare 2
    cd ComputerScience/ReverseEngineering/Tools
    git clone https://github.com/radare/radare2.git
    sudo sh radare2/sys/install.sh
		
    ### Network
    $INSTALL wireshark-cli gnu-netcat

    ### Miscelanious
    $INSTALL cowsay lolcat
}

Dotfiles()
{
    cd # Back to home again... 		

    cd ComputerScience/Programming/Repositories
    git clone https://github.com/allando/Dotfiles.git

    # Installing pathogen
    sh /home/theippo1000/ComputerScience/Programming/Repositories/Dotfiles/Vimrc/install.sh

    cd # Back to home

    # Symbolic links
    ln -s ComputerScience/Programming/Repositories/Dotfiles/Vimrc/vimrc .vimrc

    sudo rm -r .bashrc
    ln -s ComputerScience/Programming/Repositories/Dotfiles/Bashrc/bashrc .bashrc 
}

main
