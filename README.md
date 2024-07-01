My practical Linux desktop config.

## Variables
Variables are stored in `.env` and `.env.local`. `.env.local` is intended for machine-specific variables and are not tracked by Git.

The syntax of `.env` is special. Read it to know more.

```bash
ln -s $DOTFILES_PATH/{.env, .env.local, .profile} ~/
```

## Login
We use `greetd` and `tuigreet` with a custom script. Install `greetd` and `greetd-tuigreet` on Arch Linux, and edit:

```conf
# in /etc/greetd/config.toml
[default_session]
command = "tuigreet --remember --cmd start_sway"
```

Note that this depends on a properly loaded `.env` file.

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
# fuzzel: application launcher
# wezterm: terminal emulator
# swayidle && swaylock: idle management and screen lock
# swaybg: wallpaper management
# waybar: status bar
# mako: notification daemon
sudo pacman -S sway xdg-desktop-portal-wlr fcitx5-im brightnessctl wl-clipboard grim slurp swayidle swaylock swaybg mako

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

## Everything else
```bash
ln -s $DOTFILES_PATH/.pam_environment ~/
ln -s $DOTFILES_PATH/i3status-rust ~/.config/
ln -s $DOTFILES_PATH/alacritty ~/.config/
ln -s $DOTFILES_PATH/mako ~/.config/
ln -s $DOTFILES_PATH/fish ~/.config/
ln -s $DOTFILES_PATH/tmux ~/.config/
# mpd won't automatically create state folder, so do it manually
mkdir -p ~/.local/share/mpd
ln -s $DOTFILES_PATH/mpd ~/.config/
ln -s $DOTFILES_PATH/mpv ~/.config/
ln -s $DOTFILES_PATH/ncmpcpp ~/.config/
```
