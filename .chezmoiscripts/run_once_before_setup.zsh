#!/bin/zsh

# Packages to install
packages=(
    # General tools
    starship
    zoxide
    wget
    curl
    git
    lazygit
    fzf
    fd
    ripgrep
    eza
    bat
    jq

    # Important tools
    neovim
    luarocks
    gum
    # tmux
    # joshmedeski/sesh/sesh

    # Terminal
    wezterm
    # alacritty

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
