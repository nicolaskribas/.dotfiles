export PATH="$HOME/.local/bin:$PATH"

[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/$(hostnamectl hostname).profile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/$(hostnamectl hostname).profile"
