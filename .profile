# This file is sourced at login by greetd and by my .zprofile

export GNUPGHOME=${XDG_DATA_HOME:-$HOME/.local/share}/gnupg
export PASSWORD_STORE_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/pass
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export PATH=$HOME/.local/bin:$PATH

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/$(uname -n).profile" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/$(uname -n).profile"
fi
