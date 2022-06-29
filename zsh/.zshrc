# options
setopt correct
setopt extendedglob
setopt nocaseglob
setopt rcexpandparam
setopt nocheckjobs
setopt numericglobsort
setopt nobeep
setopt appendhistory
setopt histignorealldups
setopt inc_append_history
setopt histignorespace

# prompt
autoload -Uz colors
colors
PROMPT="%B%F{green}%n%b%F{8}@%B%F{cyan}%m%b%F{8}:%B%F{magenta}%3~%b%F{8}$ %f%b"

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored completion
zstyle ':completion:*' rehash true # autofind new executables
# speed up completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

WORDCHARS=${WORDCHARS//\/[&.;]}

# vi mode
bindkey -v

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # should be last
