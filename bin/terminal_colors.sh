#!/bin/bash

# old version
echo -e "\\e[0mCOLOR_NC (No color)"
echo -e "\\e[1;37mCOLOR_WHITE\\t\\e[0;30mCOLOR_BLACK"
echo -e "\\e[0;34mCOLOR_BLUE\\t\\e[1;34mCOLOR_LIGHT_BLUE"
echo -e "\\e[0;32mCOLOR_GREEN\\t\\e[1;32mCOLOR_LIGHT_GREEN"
echo -e "\\e[0;36mCOLOR_CYAN\\t\\e[1;36mCOLOR_LIGHT_CYAN"
echo -e "\\e[0;31mCOLOR_RED\\t\\e[1;31mCOLOR_LIGHT_RED"
echo -e "\\e[0;35mCOLOR_PURPLE\\t\\e[1;35mCOLOR_LIGHT_PURPLE"
echo -e "\\e[0;33mCOLOR_YELLOW\\t\\e[1;33mCOLOR_LIGHT_YELLOW"
echo -e "\\e[1;30mCOLOR_GRAY\\t\\e[0;37mCOLOR_LIGHT_GRAY"
echo

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
for fgbg in 38 48 ; do #Foreground/Background
	for color in {0..256} ; do #Colors
		#Display the color
		echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
		#Display 10 colors per lines
		if [ $((($color + 1) % 10)) == 0 ] ; then
			echo #New line
		fi
	done
	echo #New line
done
 
exit 0
