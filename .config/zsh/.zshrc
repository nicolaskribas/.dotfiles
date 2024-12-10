# --- Environment Variables ---
export EDITOR=nvim
export LESS='--RAW-CONTROL-CHARS --use-color --ignore-case --quit-if-one-screen'
export MANPAGER='less --color=u+b' # underlined -> blue
export MANROFFOPT='-P -c' # to get colors: man passes -c flag to grotty through groff (-P)
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type=file --type=dir'
export FZF_DEFAULT_OPTS='--height=11 --reverse --info=inline-right --no-separator --color=16'
eval "$(dircolors -b)" # sets `LS_COLORS` variable used in `ls` and for completion


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
alias color='stdoutisatty ' # same, but for stdoutisatty
alias dots='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias man='MANWIDTH="$((COLUMNS > 80 ? 80 : COLUMNS))" man' # limit man width to 80 columns
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g F='| fzf'


# --- Misc ---
setopt extended_glob
setopt no_clobber
setopt interactive_comments


# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zhistory"

setopt extended_history # save command's start/elapsed time to history file
setopt inc_append_history_time # append commands to history file as they finish (to record elapsed time)
setopt hist_ignore_space # don't save commands beginning with a space to the history file
setopt hist_reduce_blanks # remove superfluous blanks from each command line
setopt hist_fcntl_lock # use system call when locking history file, for performance
setopt hist_verify # don't execute the command with history expansion right away
setopt hist_find_no_dups # do not display duplicates of a line previously found, even if the duplicates are not contiguous


# --- Completion ---
setopt no_list_ambiguous # in a single tab press: insert unambiguous prefix then show comp list
setopt complete_in_word # do not jump to end of the word before completing
setopt list_packed # pack the completion list by using columns with different widths

autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*:*:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)' # one error for every three characters
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+l:|=* r:|=*' # smart-case then substring completion
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache"
zstyle ':completion:*' group-name '' # group completions by type
zstyle ':completion:*:descriptions' format '%F{green}completing %B%d%b%f' # print groups type
zstyle ':completion:*:corrections' format '%F{yellow}%d (errors: %e)%f' # _approximate
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for%f %d'
zstyle ':completion:*:functions' ignored-patterns '_*'


# --- Key Bindings ---
bindkey -v # use vi keymap
KEYTIMEOUT=1 # reduce time waited reading multi-character key bindings (fixes escape delay when exiting insert mode)

bindkey -M viins '^h' backward-delete-char # this is mapped to vi-backward-delete-char by default
bindkey -M viins '^w' backward-kill-word # this is mapped to vi-backward-kill-word by default
bindkey -M viins '^u' kill-whole-line # this is mapped to vi-kill-line by default

autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search

bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

if [[ -n "${terminfo[kcuu1]}" ]]; then # up
	bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
	bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ -n "${terminfo[kcud1]}" ]]; then # down
	bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
	bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

if [[ -n "${terminfo[kcbt]}" ]]; then # shift-tab
	zmodload zsh/complist
	bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
fi

if [[ -n "${terminfo[khome]}" ]]; then # home
	bindkey -M viins "${terminfo[khome]}" vi-beginning-of-line
	bindkey -M vicmd "${terminfo[khome]}" vi-beginning-of-line
fi

if [[ -n "${terminfo[kend]}" ]]; then # end
	bindkey -M viins "${terminfo[kend]}" vi-end-of-line
	bindkey -M vicmd "${terminfo[kend]}" vi-end-of-line
fi

if [[ -n "${terminfo[kich1]}" ]]; then # insert
	bindkey -M viins "${terminfo[kich1]}" overwrite-mode
	bindkey -M vicmd "${terminfo[kich1]}" vi-insert
fi

if [[ -n "${terminfo[kdch1]}" ]]; then # delete
	bindkey -M viins "${terminfo[kdch1]}" vi-delete-char
	bindkey -M vicmd "${terminfo[kdch1]}" vi-delete-char
fi

if [[ -n "${terminfo[kpp]}" ]]; then # page up
	bindkey -M viins "${terminfo[kpp]}" beginning-of-buffer-or-history
	bindkey -M vicmd "${terminfo[kpp]}" beginning-of-buffer-or-history
fi

if [[ -n "${terminfo[knp]}" ]]; then # page down
	bindkey -M viins "${terminfo[knp]}" end-of-buffer-or-history
	bindkey -M vicmd "${terminfo[knp]}" end-of-buffer-or-history
fi

autoload -Uz edit-command-line && zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line


# --- Cursor and Application Mode ---
zle-line-init() {
	if (( ${+terminfo[smkx]} )); then
		echoti smkx # enable terminal application mode
	fi
	print -n '\e[5 q' # starts with a blinking beam
}
zle -N zle-line-init

zle-line-finish() {
	if (( ${+terminfo[rmkx]} )); then
		echoti rmkx # disable terminal application mode
	fi
}
zle -N zle-line-finish

zle-keymap-select() {
	if [[ "$KEYMAP" == 'vicmd' ]]; then
		print -n '\e[1 q' # go to a blinking block when in vicmd
	else
		print -n '\e[5 q' # beam again when back to viins mode
	fi
}
zle -N zle-keymap-select


# --- Prompt ---
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git # enable only git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:*' formats ' [%B%b%%b%c%u]'
zstyle ':vcs_info:*' actionformats ' [%F{yellow}%a%f|%B%b%%b%c%u]'

setopt prompt_subst

# shows return code, user, hostname and current working directory
PROMPT='${EXEC_ELAPSED_TIME_FORMATED}%(?..%F{red}%B%?%b%f )%n@%B%m%b %F{blue}%B%4~%b%f${vcs_info_msg_0_} %# '

# right prompt: shows current number of background jobs
RPROMPT='%(1j.%F{blue}%B%j%b%f.)'

zmodload zsh/datetime
zmodload zsh/mathfunc

start_exec_timer() { EXEC_START_TIME=$EPOCHREALTIME }

stop_exec_timer() {
	[[ -z $EXEC_START_TIME ]] && return
	local elapsed=$((EPOCHREALTIME - EXEC_START_TIME))
	unset EXEC_START_TIME

	unset EXEC_ELAPSED_TIME_FORMATED
	[[ $elapsed -lt 1 ]] && return
	printf -v EXEC_ELAPSED_TIME_FORMATED '%s%02d:%02d%s ' '%F{yellow}%B' "$((int(elapsed/60)))" "$((int(elapsed%60)))" '%b%f'
}

set_window_title_prompt() { print -nP '\e]2;%n@%m%#\a' }

set_window_title_exec() { print -n "\e]2;${(q)1}\a" }

ring() { print -n '\a' } # print bell character

autoload -Uz add-zsh-hook
add-zsh-hook preexec set_window_title_exec
add-zsh-hook preexec start_exec_timer
add-zsh-hook precmd stop_exec_timer
add-zsh-hook precmd set_window_title_prompt
add-zsh-hook precmd ring
add-zsh-hook precmd vcs_info


# --- Plugins ---
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_ALT_C_COMMAND='fd --hidden --follow --type=dir'
source /usr/share/fzf/key-bindings.zsh # set <C-R>, <C-T> and <A-C> bindings that use fzf for selecting things

# syntax highlighting plugin, should be sourced at the end
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#e0e2ea' # fixme: remove hardcoded value (NvimLightGrey2)
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#e0e2ea' # fixme: remove hardcoded value (NvimLightGrey2)
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#e0e2ea' # fixme: remove hardcoded value (NvimLightGrey2)
ZSH_HIGHLIGHT_STYLES[redirection]='none'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#9b9ea4' # fixme: remove hardcoded value (NvimLightGrey4)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
