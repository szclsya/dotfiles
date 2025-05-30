My practical Linux desktop config.

## Variables
Variables are stored in `.config/environment.d`. `99-local.conf` is intended for machine-specific variables and are not tracked by Git.

Actual variables are generated by `30-systemd-environment-d-generator` and export-ed by `~/.profile` and fish.

```bash
ln -s $DOTFILES_PATH/environment.d ~/.config/
ln -s $DOTFILES_PATH/.profile ~/
```

## Login
We use `greetd` and `tuigreet` with a custom script. Install `greetd` and `greetd-tuigreet` on Arch Linux. Config in `greetd`. To install:

```bash
sudo pacman -S greetd greetd-tuigreet seatd
sudo cp $DOTFILES_PATH/greetd/config.toml /etc/greetd/config.toml
# This is for avoiding systemd log to litter the TUI greet screen
sudo cp $DOTFILES_PATH/systemd/system/greetd.service.d /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable seatd.service greetd.service
```

Note that this config file depends on a properly loaded `.env` file.

## systemd
Make sure you don't have exsitings systemd user services in `~/.config/systemd/user`!

To install systemd user services:
```bash
ln -s $DOTFILES_PATH/systemd/user ~/.config/systemd/
```

And enable them just like any other systemd user services.

## Niri
```bash
# xdg-desktop-portal-gnome && xdg-desktop-portal-gtk: for sharing desktop via PipeWire
# fcitx5-im: input method support (awaiting new sway release to support popup window in wezterm)
# wl-clipboard: provide CLI clipboard tools
# fuzzel: application launcher
# swayidle && swaylock: idle management and screen lock
# swaybg: wallpaper management
# waybar: status bar
# mako: notification daemon
# gnome-keyring: stores secrets
# wlsunset: Day/night gamma adjustments
sudo pacman -S niri xdg-desktop-portal-gtk xdg-desktop-portal-gnome fcitx5-im brightnessctl wl-clipboard swayidle swaylock swaybg mako gnome-keyring wlsunset
```

Then install configs:
```bash
ln -s $DOTFILES_PATH/niri ~/.config/
```

## Fontconfig
This fontconfig requires `inter-font`, `noto-fonts`, `noto-fonts-cjk`, `noto-fonts-emoji` and `ttf-sarasa-gothic`.

```bash
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic
ln -s $DOTFILES_PATH/fontconfig ~/.config/
```

## Email
`isync` for IMAP syncing, `msmtp` for SMTP sending, and `notmuch` for indexing. Viewing email in Emacs.

Password is stored in system keyring (for Sway I use gnome-keyring). Check msmtp config on how to enroll keys.

```bash
sudo pacman -S isync notmuch msmtp
ln -sf "$DOTFILES_PATH"/{isync, msmtp, notmuch} ~/.config/
mkdir -p ~/.mail/{lecs,csc,gmail}
systemctl --user enable --now notmuch.timer
```

## Git
```bash
ln -sf "$DOTFILES_PATH"/.gitconfig ~
```

## Everything else
```bash
ln -s $DOTFILES_PATH/i3status-rust ~/.config/
ln -s $DOTFILES_PATH/wezterm ~/.config/
ln -s $DOTFILES_PATH/mako ~/.config/
ln -s $DOTFILES_PATH/fish ~/.config/
ln -s $DOTFILES_PATH/tmux ~/.config/
# mpd won't automatically create state folder, so do it manually
mkdir -p ~/.local/share/mpd
ln -s $DOTFILES_PATH/mpd ~/.config/
ln -s $DOTFILES_PATH/mpv ~/.config/
ln -s $DOTFILES_PATH/ncmpcpp ~/.config/
```
