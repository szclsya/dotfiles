My practical Linux desktop config.

## Variables
Variables are stored in `.env` and `.env.local`. `.env.local` is intended for machine-specific variables and are not tracked by Git.

The syntax of `.env` is special. Read it to know more.

```bash
ln -s $DOTFILES_PATH/{.env, .env.local, .profile} ~/
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
To install systemd user services:
```bash
ln -s $DOTFILES_PATH/systemd/* ~/.config/systemd/user/
```

And enable them just like any other systemd user services.

## Sway
```bash
# xdg-desktop-portal-wlr: for sharing desktop via PipeWire
# fcitx5-im: input method support (awaiting new sway release to support popup window in wezterm)
# wl-clipboard: provide CLI clipboard tools
# grim && slurp: select a region and take a scrrenshot
# fuzzel: application launcher
# wezterm: terminal emulator
# swayidle && swaylock: idle management and screen lock
# swaybg: wallpaper management
# waybar: status bar
# mako: notification daemon
# gnome-keyring: stores secrets
sudo pacman -S sway xdg-desktop-portal-wlr fcitx5-im brightnessctl wl-clipboard grim slurp swayidle swaylock swaybg mako gnome-keyring

# Create and edit local settings (used by Sway)
cp -v ~/.dotfiles/bin/local_settings.example ~/.dotfiles/bin/local_settings
```

Sway requires `sway-session.target` from systemd to function properly.

```bash
ln -s $DOTFILES_PATH/sway ~/.config/
```

## Fontconfig
This fontconfig requires `noto-fonts`, `noto-fonts-cjk`, `noto-fonts-emoji` and `ttf-sarasa-gothic`.

```bash
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-sarasa-gothic
ln -s $DOTFILES_PATH/fontconfig ~/.config/
```

## Email
`isync` for IMAP syncing, `msmtp` for SMTP sending, and `notmuch` for indexing. Viewing email in Emacs.

```bash
sudo pacman -S isync notmuch msmtp
ln -sf "$DOTFILES_PATH"/{isync, msmtp, notmuch} ~/.config/
mkdir -p ~/.mail/{lecs,csc,gmail}
systemctl --user enable --now notmuch.timer
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
