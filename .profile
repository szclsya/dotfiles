#!/bin/bash

# Environment is managed by systemd-environment-d-generator
if [[ "$ENV_SET" -ne 1 ]] && \
   [[ -e ~/.config/environment.d ]]
   [[ -x /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator ]]
then
    export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
fi
