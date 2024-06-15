#!/bin/zsh

# Path to nvm script
export NVM_DIR="/opt/homebrew/opt/nvm"

# Source the nvm script
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
else
    echo "nvm.sh not found at $NVM_DIR"
    exit 1
fi

# Create nvm dir
if [ ! -d "$HOME/.nvm" ]; then
    mkdir "$HOME/.nvm"
fi

nvm install node
