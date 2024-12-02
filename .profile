# This file is sourced at login by greetd and by my .zprofile

export R_LIBS_USER="${XDG_DATA_HOME:-$HOME/.local/share}/R/%p-library/%v"
export R_PROFILE_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Rprofile"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH="$HOME/.local/bin:$PATH"

[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/$(hostnamectl hostname).profile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/$(hostnamectl hostname).profile"
