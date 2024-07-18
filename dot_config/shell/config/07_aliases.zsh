# NeoVim 
alias vim=nvim
alias v=nvim

# Alias to lazygit if it's installed
if command -v lazygit &>/dev/null; then
    alias lg=lazygit
else
    echo "Lazygit is not installed"
fi

# VS Code
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# Cat becomes bat
alias cat=bat

# Some color
alias ls=eza

# Chezmoi
alias cz=chezmoi
