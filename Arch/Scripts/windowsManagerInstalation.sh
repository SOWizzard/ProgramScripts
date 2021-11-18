#!/bin/bash

error() { printf "%s\n" "$1" >&2; exit 1; }

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

[ -z "$1" ] && error "choose a user"

#Basic packages
pacman --noconfirm --needed -S man-db man-pages texinfo inetutils netctl dhcpcd wpa_supplicant dialog linux-headers network-manager-applet sudo nvim nano git base-devel feh nitrogen pip ranger yad flameshot

#Xorg
pacman --noconfirm --needed -S xorg-server xorg-xinit

#DM
yay -S ly
systemctl enable ly.service

#I3 ,Polybar, Font
pacman --noconfirm --needed -S polybar
yay -S nerd-fonts-hack
pip install dbus-python
bash ./i3.sh

#Alacritty
bash ./alacritty.sh

#Browser #File manager
pacman --noconfirm --needed -S firefox
pacman --noconfirm --needed -S pacmanfm
