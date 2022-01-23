My practical Linux desktop config.

## systemd
To install systemd user services:
```bash
ln -s $DOTFILES_PATH/systemd/* ~/.config/systemd/user/
```

And enable them just like any other systemd user services.

## Sway
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
ln -s $DOTFILES_PATH/i3status-rust ~/.config/
ln -s $DOTFILES_PATH/alacritty ~/.config/
ln -s $DOTFILES_PATH/fish ~/.config/
ln -s $DOTFILES_PATH/mpd ~/.config/
ln -s $DOTFILES_PATH/mpv ~/.config/
```
