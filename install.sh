#!/bin/bash

set -e

verifyDistro()
{
	currentDistro=$(lsb_release -si)

	case currentDistro in
		"ManjaroLinux" 	):	currentDistro="manjaro";;
		"ArchLinux" 	): 	currentDistro="arch";;
		"ubuntu" 		): 	currentDistro="ubuntu";;
		"kali"			):	currentDistro="kali";;
		* ): 				echo "System not supported" && (exit 1);
	esac

	return currentDistro
}

installSystemDependentStuff()
{
	distro=$(verifyDistro)

	case currentDistro in
		"manjaro" 	): 	$(sudo arch/manjaro.sh);;
		"arch" 		):	$(sudo arch/arch.sh);;
		"ubuntu" 	): 	$(sudo debian/ubuntu.sh);;
		"kali"		):	$(sudo debian/kali.sh);;
		* ):			echo "Still not supported... How the hell did this slip through" && (exit 1);
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

main()
{
	verifyDistro
	installSystemDependentStuff

	if [[ $(verifyDistro) != "kali" ]]; then
		setUpSystems
	fi
}