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

bindkey -v

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

eval "$(starship init zsh)"
