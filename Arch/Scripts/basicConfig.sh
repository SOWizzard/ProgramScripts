#Xprofile configuration
projectDir="$(git rev-parse --show-toplevel)"
cp "${projectDir}/Arch/CFG/xprofile/xprofile" "${HOME}/.xprofile"  

#i3
projectDir="$(git rev-parse --show-toplevel)"
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.config/picom"
cp "${projectDir}/Arch/CFG/picom/picom.conf" "${XDG_CONFIG_HOME:-$HOME/.config}/picom/picom.conf"  
cp "${projectDir}/Arch/CFG/i3/config" "${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"

#alacritty
projectDir="$(git rev-parse --show-toplevel)"
mkdir -p "$HOME/.config/alacritty"
cp "${projectDir}/Arch/CFG/alacritty/default.yml" "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml"  

