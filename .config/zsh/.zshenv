export R_LIBS_USER="${XDG_DATA_HOME:-$HOME/.local/share}/R/%p-library/%v"
export R_PROFILE_USER="${XDG_CONFIG_HOME:-$HOME/.config}/R/Rprofile"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_ASKPASS=lxqt-openssh-askpass
export EDITOR=nvim
export VISUAL=nvim
export DIFFPROG='nvim -d'
export LESS='--RAW-CONTROL-CHARS --use-color --ignore-case --quit-if-one-screen'
export MANPAGER='less --color=d+m --color=u+b' # bold -> magenta, underlined -> blue
export MANROFFOPT='-P -c' # to get colors: man passes -c flag to grotty through groff (-P)
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type=file --type=dir'
export FZF_DEFAULT_OPTS='--height=11 --reverse --info=inline-right --no-separator --color=16'

typeset -U PATH path
path=(~/.local/bin $path)
