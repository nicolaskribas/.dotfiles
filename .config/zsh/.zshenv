export R_LIBS_USER=${XDG_DATA_HOME:-$HOME/.local/share}/R/%p-library/%v
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export EDITOR=nvim
export VISUAL="$EDITOR"
export BROWSER=firefox
export BEMENU_OPTS='--ignorecase --fn "sans-serif 10" --tb=#D81860FF --tf=#121212FF'
export LESS='--RAW-CONTROL-CHARS --use-color --ignore-case --quit-if-one-screen'
export MANPAGER='less --color=d+m --color=u+b' # bold -> magenta, underlined -> blue
export MANROFFOPT='-P -c' # to get colors: man passes -c flag to grotty through groff (-P)
export FZF_DEFAULT_COMMAND='fd --type=f'
export FZF_DEFAULT_OPTS='--height=11 --reverse --info=inline-right --color=16'

typeset -U path
path+=(~/.local/bin)
