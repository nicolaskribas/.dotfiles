source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "jeffreytse/zsh-vi-mode"

if ! zplug check; then
	zplug install
fi

zplug load

setopt correct
setopt extendedglob
setopt nocaseglob
setopt rcexpandparam
setopt nocheckjobs
setopt numericglobsort
setopt nobeep
setopt appendhistory
setopt histignorealldups
setopt autocd
setopt inc_append_history
setopt histignorespace

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored completion
zstyle ':completion:*' rehash true # autofind new executables

# speed up completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

WORDCHARS=${WORDCHARS//\/[&.;]}

# vi mode
bindkey -v

# history search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# home key
bindkey '^[[7~' beginning-of-line
bindkey '^[[H' beginning-of-line
if [[ "${terminfo[khome]}" != "" ]]; then
	bindkey "${terminfo[khome]}" beginning-of-line
fi

# end key
bindkey '^[[8~' end-of-line
bindkey '^[[F' end-of-line
if [[ "${terminfo[kend]}" != "" ]]; then
	bindkey "${terminfo[kend]}" end-of-line
fi

bindkey '^[[2~' overwrite-mode # insert key
bindkey '^[[3~' delete-char # delete key
bindkey '^[[C'  forward-char # right key
bindkey '^[[D'  backward-char # left key
bindkey '^[[5~' history-beginning-search-backward # page up key
bindkey '^[[6~' history-beginning-search-forward # page down key

alias cp='cp -i' # confirmation before overwriting

# ls colors
eval "$(dircolors -b)"
alias ls='ls --color=auto'

# automatically attach to tmux
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
	[ -z "${TMUX}" ] && { tmux attach || tmux; } >/dev/null 2>&1
fi

eval "$(starship init zsh)"
