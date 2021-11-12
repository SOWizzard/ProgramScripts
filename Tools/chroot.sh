# This script is a bit guided, but it still makes a few assumptions about the system.

tz="America/Sao_Paulo"
keymap="br-abnt2"
hostname="archlinux"

ln -sf /usr/share/zoneinfo/$tz /etc/localtime

hwclock --systohc

echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "KEYMAP=$keymap" >> /etc/vconsole.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Assumes hostname = archlinux
echo "$hostname" >> /etc/hostname
echo -e "127.0.0.1\tlocalhost" >> /etc/hostname
echo -e "::1\t\tlocalhost" >> /etc/hostname
echo -e "127.0.1.1\t${hostname}.localdomain\t${hostname}" >> /etc/hostname

pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager

# Create user on wheel group and configure sudo
read -p "Enter user name: " username
useradd -mG wheel "$username"
passwd "$username"
echo "Allowing wheel group to run as sudo..."
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Assumes UEFI
# Uses Intel Microcode
pacman --noconfirm --needed -S grub efibootmgr intel-ucode && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg
