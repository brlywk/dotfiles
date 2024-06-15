# Initiate completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit 

# Enable completion for 1password cli
# eval "$(op completion zsh)"; compdef _op op


# Completion should work case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
