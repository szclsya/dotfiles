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
ln -sf "$DOTFILES_PATH"/.pam_environment ~/

# systemd services
mkdir -p ~/.config/systemd/user/
ln -sf "$DOTFILES_PATH"/systemd/* ~/.config/systemd/user/

# Sway and related services and applications
ln -sf "$DOTFILES_PATH"/sway ~/.config/
ln -sf "$DOTFILES_PATH"/alacritty ~/.config/
ln -sf "$DOTFILES_PATH"/mako ~/.config/
systemctl --user enable mako.service
ln -sf "$DOTFILES_PATH"/gammastep ~/.config/
systemctl --user enable gammastep.service

# Fcitx5 and RIME config
mkdir -p ~/.config/fcitx5/conf/
ln -sf "$DOTFILES_PATH"/fcitx5/profile ~/.config/fcitx5/profile
ln -sf "$DOTFILES_PATH"/fcitx5/conf/classicui.conf ~/.config/fcitx5/conf/classicui.conf 
ln -sf "$DOTFILES_PATH"/fcitx5/themes ~/.local/share/fcitx5/themes
ln -sf "$DOTFILES_PATH"/rime ~/.local/share/fcitx5/rime

# Fontconfig
ln -sf "$DOTFILES_PATH"/fontconfig ~/.config/

# Shell and CLI utilities
ln -sf "$DOTFILES_PATH"/fish ~/.config/
ln -sf "$DOTFILES_PATH"/tmux ~/.config/

# mpd won't automatically create state folder, so do it manually
mkdir -p ~/.local/share/mpd
ln -sf "$DOTFILES_PATH"/mpd ~/.config/

ln -sf "$DOTFILES_PATH"/mpv ~/.config/
ln -sf "$DOTFILES_PATH"/ncmpcpp ~/.config/

