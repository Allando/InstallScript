#!/bin/bash

set -e

main()
{
    Update
    InstallShit
    Dotfiles
    
    mv installscript ComputerScience/Programming/Bash/Repositories/installscript
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

    echo "[*] Installing programs"
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

CreateDirectories()
{
    echo Creating directories

    # Changing current directory to home
    cd 

    # Creating home
    mkdir -v -p \
        /home/$USER/Desktop \
        /home/$USER/Documents \
        /home/$USER/Downloads \
        /home/$USER/Music \
        /home/$USER/Pictures \
        /home/$USER/Video \
		
    #Returning to home
    cd 
}

main
