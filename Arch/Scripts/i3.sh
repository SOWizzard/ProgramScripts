#!/bin/bash


sudo pacman -Syy
sudo pacman --noconfirm --needed -S picom
sudo pacman --noconfirm --needed -S i3-gaps i3status i3lock dmenu
yay -S autotiling

projectDir="$(git rev-parse --show-toplevel)"
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.config/picom"
cp "${projectDir}/Arch/CFG/picom/picom.conf" "${XDG_CONFIG_HOME:-$HOME/.config}/picom/picom.conf"  
cp "${projectDir}/Arch/CFG/i3/config" "${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"
