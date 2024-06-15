#!/bin/bash

# Monitor
xrandr --output eDP1 --mode 1366x768 --pos 1920x312 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VGA1 --off --output VIRTUAL1 --off

# NetowrkManager applet
nm-applet &

# Pulseaudio applet and prevent this binary duplicate volume icon
if pgrep -x "pa-applet" > /dev/null; then    
	exit 1
fi

# Pulseaudio
pa-applet &

# Restore wallpaper
nitrogen --restore &

# Admim Authentication
/usr/libexec/polkit-mate-authentication-agent-1 &

# Animations
picom --config ~/.config/picom/picom.conf &

# Status bar for dwm
slstatus &

# Ajust brightness on the second monitor
xbacklight -set 15 &

# Disable monitor sleep on xorg
xset r rate 300 500 &
xset s off &
xset -dpms &
