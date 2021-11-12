#!/bin/bash

# THIS IS NOT A GUIDED INSTALLER.
# It will not ask for permission and will do the following.

# This will:
# - Partition $install_dev with fdisk using the following layout:
#	NOTE: "~" = rest of the drive's size
#	   device name	size	type	label	mountpoint
#	1. /dev/sdb1	1G	fat32	BOOT	/mnt/boot
#	2. /dev/sdb2	12G	swap	SWAP	[swap]
#	3. /dev/sdb3	50G	ext4	ROOT	/mnt/
#	3. /dev/sdb4	~	ext4	HOME	/mnt/home
# - Format and mount partitions
# - Pacstrap 
# - Download $chroot_script_url to /mnt/chroot.sh and run it
# - Display a warning and reboot the machine.

# All variables go here
install_dev="/dev/sdb"
chroot_script_url="https://raw.githubusercontent.com/SOWizzard/ProgramScripts/main/Tools/chroot.sh"

sudo pacman -Syy

timedatectl set-ntp true

cat <<EOF | fdisk "$install_dev"
g
n


+1G
y
t
1
n


+12G
y
t

19
n


+50G
n



w
EOF

# FORMAT
# swap:
mkswap -L "SWAP" "${install_dev}2" 
# boot:
mkfs.fat -F32 "${install_dev}1" && fatlabel "${install_dev}1" BOOT
# root:
yes | mkfs.ext4 -L "ROOT" "${install_dev}3" 
# home:
yes | mkfs.ext4 -L "HOME" "${install_dev}4" 
# MOUNT
# swap:
swapon "${install_dev}2" 
# root:
mount "${install_dev}3" /mnt
# boot:
mkdir -p /mnt/boot
mount "${install_dev}1" /mnt/boot
# home:
mkdir -p /mnt/home
mount "${install_dev}4" /mnt/home

# Pacstrap
pacstrap /mnt base base-devel linux linux-firmware 

# Download and run chroot script
genfstab -U /mnt >> /mnt/etc/fstab
curl "$chroot_script_url" > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh

clear
echo "Base install complete. Rebooting machine in 5 seconds."
sleep 5
reboot
