#!/bin/bash

set -e

main()
{
    Update
    CreateDirectories
    InstallShit
    Dotfiles
    
    mv installscript ComputerScience/Programming/Bash/Repositories/installscript

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

InstallingSystems()
{
    card="lspci | grep -e VGA -e 30"
    install="sudo pacman -S -noconfirm"

    echo "[*] Installing Systems"
    
    echo "[*] Installing graphical user interface..."
    $install xorg-server xorg-apps

    if [ $"$card | grep -i amd" ]; then
        $install xf86-video-amdgpu
    elif [ $"$card | grep -i intel" ]; then
        $install xf86-video-intel
    elif [ $"$card | grep -i nvidia" ]; then
        $install xf86-video-nouveau
    fi
    
    echo "[*] Installing sound systems..."
    $install \
        alsa-firmware \
        alsa-plugins \
        alsa-utils \
        lib32-alsa-plugins \
        pulseaudio-alsa \
        zita-alsa-pcmi \

    echo "[*] Installing Desktop enviroment and window manager"
    $install \
        gnome \
        gnome-extra


}

CreateDirectories()
{
    echo Creating directories

    # Changing current directory to home
    cd 

    # Creating home
    mkdir -v -p \
        Desktop \
        Documents \
        Downloads \
        Music \
        Pictures \
        Video \

        .config

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
    ### Critical system software



    ### System tools
    $INSTALL yaourt htop gtop tmux

    ### Programming
    $INSTALL vim base-devel

    ### Applications
    ## Virtualbox
    $INSTALL linux414-virtualbox-host-modules virtualbox
    
    # Keep this --noconfirm untill a better solution is found.
    sudo pacman -S vte3-ng

    ## Terminal
    $INSTALL termite

    ### Reverse Engineering Tools
    ## Repositories

    #Radare 2
    cd /home/$USER/ComputerScience/ReverseEngineering/Tools
    git clone https://github.com/radare/radare2.git
    sudo sh radare2/sys/install.sh
		
    ### Network
    $INSTALL wireshark-qt gnu-netcat dnsutils nmap tracerouteT

    ### Miscelanious
    $INSTALL cowsay lolcat
}

Dotfiles()
{
    cd # Back to home again... 		

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

main
