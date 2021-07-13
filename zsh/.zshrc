zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# Plugins
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check; then
    echo; zplug install
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

zplug load

