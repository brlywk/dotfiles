# Initiate completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit 

# Some aliases
alias zshconfig="nvim ~/.zshrc"
alias vim=nvim
alias vi=nvim
alias v=nvim

# Alias to lazygit if it's installed
if command -v lazygit &>/dev/null; then
    alias lg=lazygit
else
    echo "Lazygit is not installed"
fi

# Alias air (go live reload) if installed
if [ -e "$HOME/.go/bin/air" ]; then
    alias air="~/.go/bin/air"
else
    echo "Air for Go is not installed (or not in ~/.go/bin/)"
fi

# Make NeoVim the default editor
export EDITOR=nvim

# Suggestions and auto completion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable completion for 1password cli
eval "$(op completion zsh)"; compdef _op op

# bun completions
[ -s "/Users/christoph/.bun/_bun" ] && source "/Users/christoph/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Volta
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"

# VS Code
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

###########################
#       ALWAYS LAST
# Get on board the starship
eval "$(starship init zsh)"
