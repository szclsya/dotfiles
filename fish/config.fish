# Set color
set fish_color_command green

# Set locale
if not set -q LANG
    echo "Warning: LANG not set, default to 'en_US.UTF-8'"
    export LANG=en_US.UTF-8
end

# Load ~/.env if some always-present variables are not set
# Load variables if not set
if not set -q ENV_SET \
    && test -e ~/.config/environment.d \
    && test -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator
    export (/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
end

# Alias
alias gst='git status'
alias gpg-relearn-key='gpg-connect-agent "scd serialno" "learn --force" /bye'
alias zdf='zfs list -o name,compression,compressratio,used,logicalused,available,mountpoint'
