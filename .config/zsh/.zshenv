export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export EDITOR=nvim
export VISUAL="$EDITOR"
export BROWSER=firefox
export BEMENU_OPTS='--ignorecase --list=10 --fn "monospace 11" --tb=#D81860FF --tf=#121212FF'

typeset -U path
path=(~/.local/bin $path)
