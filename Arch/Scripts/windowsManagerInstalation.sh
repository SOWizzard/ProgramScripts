#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Basic packages
pacman -S man-db man-pages texinfo inetutils netctl dhcpcd wpa_supplicant dialog linux-headers network-manager-applet sudo nvim nano

#Xorg
pacman -S xorg-server xorg-xinit

#DM
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm

#I3
bash ./i3.sh

#Browser #File manager
pacman -S firefox
pacman -S nautilus
