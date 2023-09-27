# aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -alh'
alias ring='echo -ne \\a'
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

eval "$(dircolors -b)"

# shows hostname, username and current working directory
PROMPT='%F{blue}%B%4~%b%f%# '

# right prompt: shows number of jobs and the return status of the last command
RPROMPT='%(1j.&%F{blue}%B%j%b%f.)'

# vi mode
bindkey -v
KEYTIMEOUT=1

# cursor
zle-line-init() { echo -ne '\e[5 q' } # starts with a blinking beam
zle-keymap-select() {
	if [[ "$KEYMAP" == 'vicmd' ]]; then
		echo -ne '\e[1 q' # go to blinking block when changes to vicmd
	else
		echo -ne '\e[5 q' # beam again when changing back to main/viins mode
	fi
}
zle -N zle-line-init
zle -N zle-keymap-select


zmodload zsh/datetime
zmodload zsh/mathfunc

start_exec_timer() {
	EXEC_START_TIME=$EPOCHREALTIME
}

stop_exec_timer() {
    [[ -z $EXEC_START_TIME ]] && return
	EXEC_ELAPSED_TIME=$((EPOCHREALTIME - EXEC_START_TIME))
	unset EXEC_START_TIME
}

print_preprompt() {
	local error_code=$(print -nP '%(?..=%F{red}%B%?%b%f)')
	[[ -n "$error_code" ]] && print "$error_code"

	[[ -z $EXEC_ELAPSED_TIME ]] && return
	local elapsed=$EXEC_ELAPSED_TIME
	unset EXEC_ELAPSED_TIME

	[[ $elapsed -lt 1 ]] && return
	local mins=$((int(elapsed/60)))
	local secs=$((int(elapsed%60)))
	print -n "took "
	[[ $mins -ne 0 ]] && print -nP "%F{yellow}%B${mins}%b%f min and "
	print -P "%F{yellow}%B${secs}%b%f s"
}

autoload -U add-zsh-hook
add-zsh-hook preexec start_exec_timer
add-zsh-hook precmd stop_exec_timer
add-zsh-hook precmd print_preprompt


# misc options
setopt correct
setopt extended_glob
setopt no_beep

# directory stack
setopt cd_silent
setopt auto_pushd
setopt pushd_ignore_dups
sd() {
	dirs -v | head -n 10
	read -k 'index?#> '
	echo
	if [[ "$index" =~ '[0-9]' ]]; then
		cd +"$index"
	else
		echo 'Nothing selected'
	fi
	unset index
}

# history
setopt extended_history
setopt inc_append_history_time
setopt hist_ignore_all_dups
setopt hist_ignore_space
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zhistory
HISTSIZE=10000
SAVEHIST=10000

# bindings
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
autoload -U edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# completion
setopt list_packed
autoload -U compinit; compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}[%d]%f'
zstyle ':completion:*:messages' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- No matches found --%f'

# syntax highlighting plugin, should be loaded last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
