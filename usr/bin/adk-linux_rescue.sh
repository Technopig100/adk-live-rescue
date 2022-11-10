#!/bin/sh
set -e
#QuickADK-Linux rescue scipt
printf '\e[1;34m%-6s\e[m' "########################### ADK-Linux Quick Rescue Script ##############################"
printf "\n"
printf '\e[1;34m%-6s\e[m' "###### We will use lsblk to identify the disk partion our subvols are located on! #######"
printf "\n"
printf '\e[1;34m%-6s\e[m' "########################################################################################"
printf "\n"
read -p "Press any key to continue"
lsblk
printf '\e[1;34m%-6s\e[m' "What is the partion name that btrfs subvolume root '/' is located on?: "
read PN
sudo mount -o subvol=@ /dev/${PN} /mnt
printf "\n\n"

printf '\e[1;34m%-6s\e[m' "What is the partion name that /boot/efi partion is located on?: "
read BP
sudo mount /dev/${BP} /mnt/boot/efi
printf "\n\n"

## Mount remaining subvolumes ##
sudo arch-chroot /mnt mount -a

## Chroot into ADK-Linux ##
sudo arch-chroot /mnt

## un-mount everything ##
sudo umount -R /mnt