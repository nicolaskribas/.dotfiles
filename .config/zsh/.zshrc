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
alias ring='echo -ne "\a"' # send bell character
alias dots='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias man='MANWIDTH="$((COLUMNS > 80 ? 80 : COLUMNS))" man' # limit man width to 80 columns
alias pacdiff='pacdiff --sudo --threeway'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'


# --- Vi Mode ---
bindkey -v # use vi keymap

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload -U edit-command-line && zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line


# --- Cursor ---
zle-line-init() { echo -ne '\e[5 q' } # starts with a blinking beam
zle -N zle-line-init

zle-keymap-select() {
	if [[ "$KEYMAP" == 'vicmd' ]]; then
		echo -ne '\e[1 q' # go to a blinking block when in vicmd
	else
		zle-line-init # beam again when back to main/viins mode
	fi
}
zle -N zle-keymap-select


# --- Prompt ---
# shows current working directory
PROMPT='%(?..?%F{red}%B%?%b%f )%n@%m %B%4~%b %# '

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
	[[ -z $EXEC_ELAPSED_TIME ]] && return
	local elapsed=$EXEC_ELAPSED_TIME
	unset EXEC_ELAPSED_TIME

	[[ $elapsed -lt 1 ]] && return
	local mins=$(printf "%02d" $((int(elapsed/60))))
	local secs=$(printf "%02d" $((int(elapsed%60))))
	local cents=${elapsed#*.}
	print -P "%F{yellow}%B${mins}′${secs}″\u208${cents[1]}\u208${cents[2]}%b%f"
	ring # the bell
}

autoload -U add-zsh-hook
add-zsh-hook preexec start_exec_timer
add-zsh-hook precmd stop_exec_timer
add-zsh-hook precmd print_preprompt


# --- Other Options ---
setopt extended_glob
setopt no_clobber
setopt interactive_comments


# --- Files and Directories ---
eval "$(dircolors -b)" # setup colors for `ls`

FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_ALT_C_COMMAND='fd --hidden --follow --type=dir'
eval "$(fzf --zsh)" # set <C-R>, <C-T> and <A-C> bindings that use fzf for selecting things


# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zhistory"
setopt extended_history # save command's start/elapsed time to history file
setopt inc_append_history_time # append commands to history file as they finish (to record elapsed time)
setopt hist_ignore_space # don't save commands begining with a space to the history file
setopt hist_reduce_blanks # remove superfluous blanks from each command line
setopt hist_fcntl_lock # use system call when locking history file, for performance
setopt hist_verify # don't execute the command with history expansion right away


# --- Completion ---
setopt list_packed
autoload -U compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' # smart-case completion
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}completing %B%d%b%f'
zstyle ':completion:*:messages' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for%f %d'

# --- Plugins ---
# syntax highlighting plugin, should be sourced at the end
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
