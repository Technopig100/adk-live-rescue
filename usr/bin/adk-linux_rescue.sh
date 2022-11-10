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
printf "\n"
printf '\e[1;34m%-6s\e[m' "## Determine name of partion btfrs subvol root is mounted on example "sda2" or 'nvme0n1p2' ##"
printf '\e[1;34m%-6s\e[m' "## example ##"
printf '\e[1;34m%-6s\e[m' "# NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS"
printf '\e[1;34m%-6s\e[m' "# loop0    7:0    0  2.5G  1 loop" 
printf '\e[1;34m%-6s\e[m' "# sda      8:0    0   40G  0 disk "
printf '\e[1;34m%-6s\e[m' "# ├─sda1   8:1    0  300M  0 part /boot/efi   <===='This is your efi/boot partion mounted on sda1'====="
printf '\e[1;34m%-6s\e[m' "# ├─sda2   8:2    0 31.3G  0 part /var/cache  <===='This is your btrfs subvol cache'=====  \ "
printf '\e[1;34m%-6s\e[m' "# │                               /home       <===='This is your btfrs subvol home'======   |== sda2"
printf '\e[1;34m%-6s\e[m' "# │                               /           <===='This is your btrfs subvol root'======  / "
printf '\e[1;34m%-6s\e[m' "# └─sda3   8:3    0  8.4G  0 part" 
printf '\e[1;34m%-6s\e[m' "# sr0     11:0    1  2.7G  0 rom"
printf "\n"
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