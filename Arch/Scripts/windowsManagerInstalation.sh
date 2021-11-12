#!/bin/bash

error() { printf "%s\n" "$1" >&2; exit 1; }

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

[ -z "$1" ] && error "choose a user"

#Basic packages
pacman --noconfirm --needed -S man-db man-pages texinfo inetutils netctl dhcpcd wpa_supplicant dialog linux-headers network-manager-applet sudo nvim nano git base-devel

#Xorg
pacman --noconfirm --needed -S xorg-server xorg-xinit

#DM
pacman --noconfirm --needed -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm



#I3
bash ./i3.sh

#Alacritty
bash ./alacritty.sh

#Browser #File manager
pacman --noconfirm --needed -S firefox
pacman --noconfirm --needed -S nautilus
