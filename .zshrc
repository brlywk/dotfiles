# Initiate completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit 

# Some aliases
alias zshconfig='nvim ~/.zshrc'
alias vim=nvim
alias vi=nvim
alias v=nvim

# Make NeoVim the default editor
export EDITOR=nvim

# Suggestions and auto completion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable nodenv
eval "$(nodenv init -)"

# Enable completion for 1password cli
eval "$(op completion zsh)"; compdef _op op

# bun completions
[ -s "/Users/christoph/.bun/_bun" ] && source "/Users/christoph/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Always run tmux and attach / create 'default' session
if [ -z "$TMUX" ]; then
    tmux attach -t default  || tmux new-session -s default
fi

###########################
#       ALWAYS LAST
# Get on board the starship
eval "$(starship init zsh)"
