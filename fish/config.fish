# Set color
set fish_color_command green

# Set locale
export LANG=en_US.UTF-8
# Set editor
export EDITOR=vim
# Set hledger default file
export LEDGER_FILE=$HOME/Documents/ledger/current.journal

# Alias
alias l='ls -al'
alias gst='git status'
alias gpg-relearn-key='gpg-connect-agent "scd serialno" "learn --force" /bye'
alias sk='bash ~/.dotfiles/bin/start_kde'
alias skx='startx ~/.dotfiles/bin/start_kde_x11'
alias ss='bash ~/.dotfiles/bin/start_sway'
