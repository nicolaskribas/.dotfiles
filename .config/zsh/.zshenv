export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export EDITOR=nvim
export VISUAL="$EDITOR"
export BROWSER=firefox

typeset -U path
path=(~/.local/bin $path)
