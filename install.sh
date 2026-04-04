#!/bin/bash

set -e # exit on error

# packges list
source packages.conf


# update before installation
sudo pacman -Syu --noconfirm

# install pacman packages
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# checking for yay
if ! command -v yay >/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi



# install aur packages
yay -S --needed --noconfirm "${AUR_PKGS[@]}"


# enable services
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service

# clone dotfiles repo to home dir
git clone https://github.com/OmerWolkoon/dotfiles.git ~/.dotfiles --depth=1
# load .bashrc file
cp ~/.dotfiles/.bashrc ~/.bashrc
# load configs
mkdir -p ~/.config
cp -r ~/.dotfiles/.config/* ~/.config/
# set wallpaper
swww img ~/.dotfiles/alena-aenami-budapest.jpg
