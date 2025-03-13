#!/bin/bash

# Environment is managed by systemd-environment-d-generator
if [[ "$ENV_SET" -ne 1 ]] && \
   [[ -e ~/.config/environment.d ]]
   [[ -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator ]]
then
    export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
fi

# Setup gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Set-up GnuPG
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
