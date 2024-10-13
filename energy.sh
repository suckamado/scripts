#!/bin/bash

style="power"
rofi_command="rofi -theme /usr/share/rofi/themes/dmenu.rasi"

# Options
shutdown="Encerrar"
reboot="Reinciar"

# Variable passed to rofi
options="$shutdown\n$reboot"

chosen="$(echo -e "$options" | $rofi_command -p " Encerrar " -dmenu -selected-row 2)"

case $chosen in
    $shutdown)
    	doas /usr/bin/shutdown -h now
	;;
    $reboot)
    	doas /usr/bin/shutdown -r now
        ;;
esac
