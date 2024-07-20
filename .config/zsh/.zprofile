export R_LIBS_USER="${XDG_DATA_HOME:-$HOME/.local/share}/R/%p-library/%v"
export R_PROFILE_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Rprofile"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

typeset -U PATH path
path=(~/.local/bin $path)

[ "$(tty)" = '/dev/tty1' ] && exec launch-sway
