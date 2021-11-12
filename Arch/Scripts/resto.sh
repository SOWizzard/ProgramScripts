#Xprofile configuration
projectDir="$(git rev-parse --show-toplevel)"
cp "${projectDir}/Arch/CFG/xprofile/xprofile" "${HOME}/.xprofile"  

#YAY
git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
cd ~/yay-bin
makepkg -si

#I3
bash ./i3.sh

#Alacritty
bash ./alacritty.sh

#Browser #File manager
pacman --noconfirm --needed -S firefox
pacman --noconfirm --needed -S nautilus
