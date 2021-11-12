#!/bin/bash


sudo pacman -Syy
sudo pacman --noconfirm --needed -S picom
sudo pacman --noconfirm --needed -S i3-gaps i3status i3lock dmenu
yay -S autotiling

