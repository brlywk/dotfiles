#!/bin/zsh

# Packages to install
packages=(
    # General tools
    starship
    zoxide
    wget
    curl
    git
    fzf
    fd
    ripgrep
    eza
    bat
    jq
    chezmoi

    # Important tools
    luarocks
    neovim
    gum

    # Terminal
    wezterm

    # Dev stuff
    go
    rustup
    nvm
    lazygit
    tokei

    # Services
    turso
    docker

    # Some more useful tools
    yazi
    jstkdng/programs/ueberzugpp

    # Some fun stuff
    slides
)

# Install all the packages!
for package in "${packages[@]}"; do
    echo "Installing $package..."
    brew install $package
done

echo "All packages installed."
