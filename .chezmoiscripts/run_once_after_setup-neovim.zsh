#!/bin/zsh

# Install some necessary packages
echo "Installing Neovim NPM package..."
npm install -g neovim

# Clone neovim config
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone gh:brlywk/nvim ~/.config/nvim
fi
