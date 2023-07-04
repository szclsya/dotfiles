#!/bin/bash
set -euo pipefail

DOTFILES_PATH=$(pwd)
AUR_HELPER="paru"

if [[ "$*" == '--install' ]]; then
    echo "Installing Sway and related services and applications..."
    sudo pacman -S sway xdg-desktop-portal-wlr brightnessctl wl-clipboard grim slurp swayidle swaylock swaybg mako waybar
    echo "Installing Fcitx5 and RIME..."
    sudo pacman -S fcitx5-im fcitx5-rime rime-pinyin-zhwiki
    "$AUR_HELPER" -S rime-aurora-pinyin-git
    echo "Installing fonts..."
    sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic
fi

# User variables
ln -s "$DOTFILES_PATH"/.pam_environment ~/

# systemd services
mkdir -p ~/.config/systemd/user/
ln -s "$DOTFILES_PATH"/systemd/* ~/.config/systemd/user/
systemctl --user enable fcitx5.service

# Sway and related services and applications
ln -s "$DOTFILES_PATH"/sway ~/.config/
ln -s "$DOTFILES_PATH"/alacritty ~/.config/
ln -s "$DOTFILES_PATH"/mako ~/.config/
systemctl --user enable mako.service
ln -s "$DOTFILES_PATH"/gammastep ~/.config/
systemctl --user enable gammastep.service

# Fontconfig
ln -s "$DOTFILES_PATH"/fontconfig ~/.config/

# Shell and CLI utilities
ln -s "$DOTFILES_PATH"/fish ~/.config/
ln -s "$DOTFILES_PATH"/tmux ~/.config/

# mpd won't automatically create state folder, so do it manually
mkdir -p ~/.local/share/mpd
ln -s "$DOTFILES_PATH"/mpd ~/.config/

ln -s "$DOTFILES_PATH"/mpv ~/.config/
ln -s "$DOTFILES_PATH"/ncmpcpp ~/.config/

