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
	AutoRemove

	cowsay "ALL DONE!!!" | lolcat -a
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
	mkdir -p CTF/Ŕoot-Me \
	Scripts/Repositories \
	Scripts/LocalScripts

	echo $(tput setaf 2)'Done!'$(tput sgr0)
}

Repositories()
{
	sysDir="SystemStuff/Repositories/"

	echo $(tput setaf 6)'Cloning Repositories'$(tput sgr0)
	
	#Allando Repositories
	$clone https://github.com/allando/updatescript.git $sysDir
	$clone https://github.com/allando/vimrc.git $sysDir

	# peda-gdp
	git clone https://github.com/longld/peda.git ~/peda
	echo "source ~/peda/peda.py" >> ~/.gdbinit
	echo "DONE! debug your program with gdb and enjoy"

	echo $(tput setaf 2)'Done!'$(tput sgr0)
}

# Installing()
# {
# 	echo $(tput setaf 6)'Installing'$(tput sgr0)
	
# 	$install gdb-peda

# 	echo $(tput setaf 2)'Installing complete!'$(tput sgr0)
# }

# Uninstalling()
# {
# 	echo $(tput setaf 6)'Uninstalling'$(tput sgr0)

	

# 	echo $(tput setaf 2)'Uninstalling complete!'$(tput sgr0)
# }

AutoRemove()
{
	echo $(tput setaf 6)'Auto Removing'$(tput sgr0)

	if [[ $(apt -y autoremove) ]]; then
		echo $(tput setaf 2)'Auto removing complete'$(tput sgr0)
	else
		echo $(tput setaf 2)'No need for autoremoving'$(tput agr0)
	fi
}

main
