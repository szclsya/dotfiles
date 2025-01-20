#!/bin/bash
set -euo pipefail

DOTFILES_PATH=$(pwd)
AUR_HELPER="paru"
INFO_PREFIX="\e[1;94m[INFO] \e[0m"
ERROR_PREFIX="\e[1;91m[ERROR]\e[0m"

# Get distro
. /etc/os-release

read -rp $'\e[1;97mAllow sudo? (y/n)\e[0m ' SYSTEM
ARCH_INSTALL="n"

if [[ $SYSTEM == "y" ]] && [[ $NAME == "Arch Linux" ]]; then
    read -rp $'\e[1;97mArch Linux detected. Use pacman and $AUR_HELPER to install packages?\e[0m ' ARCH_INSTALL
fi

if [[ $ARCH_INSTALL == "y" ]]; then
    if ! [[ -x $(command -v $AUR_HELPER) ]]; then
        echo -e "$ERROR_PREFIX AUR helper $AUR_HELPER not found! Exiting"
        exit 1
    fi
    echo -e "$INFO_PREFIX Installing login manager (greetd)"
    sudo pacman -S seatd greetd greetd-tuigreet
    echo -e "$INFO_PREFIX Installing Sway and related services and applications"
    sudo pacman -S sway xdg-desktop-portal-wlr brightnessctl wl-clipboard grim slurp swayidle swaybg mako waybar foot fuzzel gammastep
    "$AUR_HELPER" swaylock-effects
    echo -e "$INFO_PREFIX Installing Fcitx5 and RIME"
    sudo pacman -S fcitx5-im fcitx5-rime rime-pinyin-zhwiki
    "$AUR_HELPER" -S rime-aurora-pinyin-git
    echo -e "$INFO_PREFIX Install Email tools"
    sudo pacman -S isync msmtp notmuch
    echo -e "$INFO_PREFIX Installing fonts"
    sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic ttf-nerd-fonts-symbols
fi

if [[ $SYSTEM == "y" ]]; then
    echo -e "$INFO_PREFIX Installing system-wide configs"
    # greetd
    sudo cp -rv "$DOTFILES_PATH"/systemd/system/greetd.service.d /etc/systemd/system/
    sudo cp -v "$DOTFILES_PATH"/greetd/* /etc/greetd/
    sudo systemctl enable seatd.service greetd.service
fi

# User variables
ln -sfv "$DOTFILES_PATH"/.profile ~/
mkdir ~/.config
ln -sfv "$DOTFILES_PATH"/environment.d ~/.config/

# systemd services
mkdir -pv ~/.config/systemd/user/
ln -sfv "$DOTFILES_PATH"/systemd/user/* ~/.config/systemd/user/
systemctl --user daemon-reload

# Sway and related services and applications
ln -sfv "$DOTFILES_PATH"/sway ~/.config/
ln -sfv "$DOTFILES_PATH"/foot ~/.config/
ln -sfv "$DOTFILES_PATH"/mako ~/.config/
systemctl --user enable mako.service
ln -sfv "$DOTFILES_PATH"/gammastep ~/.config/
systemctl --user enable gammastep.service
ln -sfv "$DOTFILES_PATH"/waybar ~/.config/
systemctl --user enable waybar.service

# Fcitx5 and RIME config
mkdir -pv ~/.config/fcitx5/conf/ ~/.local/share/fcitx5/themes
ln -sfv "$DOTFILES_PATH"/fcitx5/profile ~/.config/fcitx5/profile
ln -sfv "$DOTFILES_PATH"/fcitx5/conf/classicui.conf ~/.config/fcitx5/conf/classicui.conf 
ln -sfv "$DOTFILES_PATH"/fcitx5/themes ~/.local/share/fcitx5/themes
ln -sfv "$DOTFILES_PATH"/rime ~/.local/share/fcitx5/
systemctl --user enable fcitx5.service

# Fontconfig
ln -sfv "$DOTFILES_PATH"/fontconfig ~/.config/

# Shell and CLI utilities
ln -sfv "$DOTFILES_PATH"/fish ~/.config/
ln -sfv "$DOTFILES_PATH"/tmux ~/.config/

# Email
ln -sfv "$DOTFILES_PATH"/{isync,msmtp,notmuch} ~/.config/
mkdir -pv ~/.mail/{lecs,csc,gmail}
systemctl --user enable --now notmuch.timer

# mpd won't automatically create state folder, so do it manually
mkdir -pv ~/.local/share/mpd
ln -sfv "$DOTFILES_PATH"/mpd ~/.config/

ln -sfv "$DOTFILES_PATH"/mpv ~/.config/
ln -sfv "$DOTFILES_PATH"/ncmpcpp ~/.config/

# GnuPG freaks out if GNUPGHOME is not a folder, so do it manually
mkdir -pv ~/.local/share/gnupg
chmod -R 700 ~/.local/share/gnupg
ln -sfv "$DOTFILES_PATH"/gnupg/gpg-agent.conf ~/.local/share/gnupg
