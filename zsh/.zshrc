# antigen needs to be set up separately.
# curl -L git.io/antigen > ~/.zsh/antigen.zsh
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Fish-like autocomplete bundle.
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme ys

# Tell Antigen that you're done.
antigen apply

# Use complist
zmodload -i zsh/complist
autoload -U compinit && compinit
compinit -d ~/.zcompdump_capture

# Set locale
export LANG=en_US.UTF-8
# Set editor
export EDITOR=vim

# Alias
alias starti3='startx ~/.dotfiles/general/xinitrc_i3'
alias startkde='startx ~/.dotfiles/general/xinitrc_kde'
