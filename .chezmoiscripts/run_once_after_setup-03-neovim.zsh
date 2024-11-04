#!/bin/zsh

# Clone neovim config
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone gh:brlywk/nvim ~/.config/nvim
else
    echo "Neovim already set up..."
fi

# Install some necessary packages
echo "Installing Neovim NPM package..."
npm install -g neovim
