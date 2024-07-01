# Set color
set fish_color_command green

# Set locale
if not set -q LANG
    echo "Warning: LANG not set, default to 'en_US.UTF-8'"
    export LANG=en_US.UTF-8
end

# Load ~/.env if some always-present variables are not set
if not set -q ENV_SET
    function setenv; set -gx $argv; end
    source ~/.env
end

# Alias
alias gst='git status'
alias gpg-relearn-key='gpg-connect-agent "scd serialno" "learn --force" /bye'
