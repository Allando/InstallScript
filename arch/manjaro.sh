#!/bin/bash

set -e

INSTALL="sudo pacman -S --noconfirm"

### System tools
$INSTALL base-devel \
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

### Reverse Engineering Tools

# Radare 2 from reposetories
cd /home/$USER/ComputerScience/ReverseEngineering/Tools
git clone https://github.com/radare/radare2.git
sudo sh radare2/sys/install.sh
