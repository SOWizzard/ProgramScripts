sudo pacman --noconfirm --needed -S alacritty

projectDir="$(git rev-parse --show-toplevel)"
mkdir -p "$HOME/.config/alacritty"
cp "${projectDir}/Arch/CFG/alacritty/default.yml" "${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml"  
