#!/bin/bash

set -e

$NOTIFY="$(tput setaf 6)[*]$(tput sgr0)"
$SUCCESS="$(tput setaf 2)[*]$(tput sgr0)"
$FAILURE="$(tput setaf 1)[*]$(tput sgr0)"

main()
{
		Update
		CreateDirectories
		InstallShit

		cowsay "ALL FUCKING DONE!!!" | lolcat -a
}

Update()
{
		echo $NOTIFY Updating...

		if (sudo pacman -Syyu); then
				echo $SUCCESS Update complete
		else
				echo $FAILURE Update failed
		fi
}

CreateDirectories()
{
		echo $NOTIFY Creating directories

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

		cd
}

InstallShit()
{
		echo $SUCCESS Installing stuffs
		
		### System tools
		sudo pacman -S yaourt htop gtop

		### Programming
		sudo pacman -S vim base-devel

		### Applications
		## Virtualbox

		sudo pacman -S linux49-virtualbox-host-modules virtualbox

		### Reverse Engineering Tools
		## Repositories

		#Radare 2
		cd ComputerScience/ReverseEngineering/Tools
		git clone https://github.com/radare/radare2.git
		sh radare2/sys/install.sh
		
		### Network
		pacman -S wireshark gnu-netcat

		### Miscelanious
		pacman -S cowsay lolcat
}

