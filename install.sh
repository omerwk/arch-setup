#!/bin/bash

PURPLE='\033[0;35m'
set -e # exit on error

# packges list

echo "${PURPLE}  Loading package list..."
source packages.conf

# update before installation

echo "${PURPLE}  Updating system before installation of packages"
sudo pacman -Syu --noconfirm

# install pacman packages
echo "${PURPLE}  Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# checking for yay
if ! command -v yay >/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    echo "${PURPLE}}  yay not found, installing it now..."
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# install aur packages
echo "${PURPLE}  Installing AUR packages"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# enable services
echo "${PURPLE}  Enabling system services"
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service

echo "${PURPLE}  Loading configs..."
# clone dotfiles repo to home dir
git clone https://github.com/OmerWolkoon/dotfiles.git ~/Omer/dotfiles --depth=1

# load .bashrc file
cp ~/Omer/dotfiles/.bashrc ~/.bashrc

# load configs
mkdir -p ~/.config
cp -r ~/Omer/dotfiles/.config/* ~/.config/

# set wallpaper
echo "${PURPLE}  Setting wallpaper"
mkdir -p ~/Omer/Images
cp ~/Omer/dotfiles/alena-aenami-budapest.jpg ~/Omer/Images/
waypaper --wallpaper ~/Omer/Images/alene-aenami-budapest.jpg
>>>>>>> 364dbcd (added progress announcements)
