My practical Linux desktop config.

## systemd
To install systemd user services:
```bash
ln -s $DOTFILES_PATH/systemd/* ~/.config/systemd/user/
```

And enable them just like any other systemd user services.

## Sway
```bash
# xdg-desktop-portal-wlr: for sharing desktop via PipeWire
# fcitx5-im: input method support (currently doesn't work well with alacritty)
# wl-clipboard: provide CLI clipboard tools
# grim && slurp: select a region and take a scrrenshot
# bemenu && j4-dmenu-desktop (AUR): application launcher
# alacritty: terminal emulator
# swayidle && swaylock: idle management and screen lock
# swaybg: wallpaper management
# i3status-rust: status bar
# mako: notification daemon
sudo pacman -S sway xdg-desktop-portal-wlr fcitx5-im brightnessctl wl-clipboard grim slurp bemenu-wayland swayidle swaylock swaybg i3status-rust mako
$YOUR_AUR_HELPER -S j4-dmenu-desktop
```

Sway requires `sway-session.target` from systemd to function properly.

```bash
ln -s $DOTFILES_PATH/sway ~/.config/
```

## Fontconfig
This fontconfig requires `noto-fonts`, `noto-fonts-cjk`, `noto-fonts-emoji` and `ttf-sarasa-gothic`.

```bash
ln -s $DOTFILES_PATH/fontconfig ~/.config/
```

## Everything else
```bash
ln -s $DOTFILES_PATH/.pam_environment ~/
ln -s $DOTFILES_PATH/i3status-rust ~/.config/
ln -s $DOTFILES_PATH/alacritty ~/.config/
ln -s $DOTFILES_PATH/mako ~/.config/
ln -s $DOTFILES_PATH/fish ~/.config/
ln -s $DOTFILES_PATH/tmux ~/.config/
ln -s $DOTFILES_PATH/mpd ~/.config/
ln -s $DOTFILES_PATH/mpv ~/.config/
ln -s $DOTFILES_PATH/ncmpcpp ~/.config/
```
