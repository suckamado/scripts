#!/bin/bash

xrandr --output eDP1 --mode 1366x768 --pos 1920x312 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VGA1 --off --output VIRTUAL1 --off

nm-applet & 
pa-applet &

nitrogen --restore &

/usr/libexec/polkit-mate-authentication-agent-1 &

picom --config ~/.config/picom/picom.conf &

slstatus &

xbacklight -set 15 &

xset r rate 300 500 &
xset s off &
xset -dpms &
