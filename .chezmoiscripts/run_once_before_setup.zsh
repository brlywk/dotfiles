#!/bin/zsh

# Packages to install
packages=(
    # General tools
    wget
    curl
    git
    lazygit
    zoxide
    fzf
    fd
    ripgrep
    eza
    bat
    jq
    jandedobbeleer/oh-my-posh/oh-my-posh

    # Important tools
    neovim
    luarocks
    tmux
    gum
    joshmedeski/sesh/sesh

    # Terminal
    wezterm

    # Languages
    go
    rustup
    nvm

    # Services
    turso
    docker

    # Some more useful tools
    tree
    yazi
    jstkdng/programs/ueberzugpp
    tokei
)

# Install all the packages!
for package in "${packages[@]}"; do
    echo "Installing $package..."
    brew install $package
done

echo "All packages installed."
