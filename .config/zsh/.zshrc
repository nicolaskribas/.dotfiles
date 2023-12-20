# --- Aliases ---
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -alh'
alias ip='ip -color=auto'
alias sudo='sudo ' # expand command passed to sudo if it is an alias
alias xargs='xargs ' # same, but for xargs
alias watch='watch --color ' # same, but for watch
alias ring='echo -ne \\a' # send bell character
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'


# --- Vi Mode ---
bindkey -v # use vi keymap
KEYTIMEOUT=1 # reduce time waited reading multi-character sequences (fixes escape delay when exiting insert mode)

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -U edit-command-line; zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line


# --- Cursor ---
zle-line-init() { echo -ne '\e[6 q' } # starts with a beam
zle -N zle-line-init

zle-keymap-select() {
	if [[ "$KEYMAP" == 'vicmd' ]]; then
		echo -ne '\e[2 q' # go to a block when in vicmd
	else
		zle-line-init # beam again when back to main/viins mode
	fi
}
zle -N zle-keymap-select


# --- Prompt ---
# shows current working directory
PROMPT='[%F{blue}%B%4~%b%f]%# '

# right prompt: shows current number of background jobs
RPROMPT='%(1j.&%F{blue}%B%j%b%f.)'

zmodload zsh/datetime
zmodload zsh/mathfunc

start_exec_timer() { EXEC_START_TIME=$EPOCHREALTIME }

stop_exec_timer() {
	[[ -z $EXEC_START_TIME ]] && return
	EXEC_ELAPSED_TIME=$((EPOCHREALTIME - EXEC_START_TIME))
	unset EXEC_START_TIME
}

print_preprompt() {
	print -nP '%(?..?%F{red}%B%?%b%f\n)'

	[[ -z $EXEC_ELAPSED_TIME ]] && return
	local elapsed=$EXEC_ELAPSED_TIME
	unset EXEC_ELAPSED_TIME

	[[ $elapsed -lt 1 ]] && return
	local mins=$(printf "%02d" $((int(elapsed/60))))
	local secs=$(printf "%02d" $((int(elapsed%60))))
	print -P "*%F{yellow}%B${mins}′${secs}%b%f"
}

autoload -U add-zsh-hook
add-zsh-hook preexec start_exec_timer
add-zsh-hook precmd stop_exec_timer
add-zsh-hook precmd print_preprompt


# --- Other Options ---
setopt correct
setopt extended_glob
setopt no_beep


# --- Files and Directories ---
eval "$(dircolors -b)" # setup colors for `ls`

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

fzf-file-widget(){
	local line
	fd | fzf --multi --scheme=path | while read line; do LBUFFER="$LBUFFER$line " done
	zle reset-prompt
}
zle -N fzf-file-widget
bindkey -M viins '^T' fzf-file-widget


# --- History ---
setopt extended_history # save command's start/elapsed time to history file
setopt inc_append_history_time # append commands to history file as they finish (to record elapsed time)
setopt hist_ignore_space # don't save commands begining with a space to the history file
setopt hist_reduce_blanks # remove superfluous blanks from each command line
setopt hist_fcntl_lock # use system call when locking history file, for performance
setopt hist_verify # don't execute the command with history expansion right away
HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zhistory
HISTSIZE=10000
SAVEHIST=10000

fzf-history-widget() {
	zle zle-line-init
	local selected=($(fc -lr 1 |\
		awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |\
		fzf --scheme=history --query="$BUFFER"))
	zle zle-keymap-select
	local ret="$?"
	if [ -n "$selected" ]; then
		local num="$selected[1]";
		if [ -n "$num" ]; then
			zle vi-fetch-history -n "$num"
		fi
	fi
	zle reset-prompt
	return "$ret"
}
zle -N fzf-history-widget
bindkey -M vicmd '/' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget


# --- Completion ---
setopt list_packed
autoload -U compinit; compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' extra-verbose true
zstyle ':completion:*:descriptions' format '%F{green}[%d]%f'
zstyle ':completion:*:messages' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- No matches found --%f'


# --- Plugins ---
# syntax highlighting plugin, should be sourced at the end
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
