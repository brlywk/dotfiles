#!/bin/bash

# List of files and directories to synchronize
FILES_AND_DIRS=(
    # oh-my-zsh settings
    "~/.zshrc"
    # nvim config
    "~/.config/nvim"
    # alacritty config
    "~/.config/alacritty.yml"
    # tmux config
    "~/.config/tmux"
    # wezterm
    "~/.config/wezterm"
)

# List of subdirectories to exclude from synchronization
EXCLUDE_SUBDIRS=(
    # Exclude the 'plugins' subdirectory from nvim config
    "~/.config/tmux/plugins"
)

# Destination directory
DEST_DIR="$HOME/.dotfiles"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Copy files and directories
for item in "${FILES_AND_DIRS[@]}"; do
    # Replace home directory tilde with the actual path
    item="${item/#\~/$HOME}"

    # Check if the item is in the excluded subdirectories list
    skip_item=false
    for subdir in "${EXCLUDE_SUBDIRS[@]}"; do
        subdir="${subdir/#\~/$HOME}"
        if [[ "$item" == "$subdir"* ]]; then
            skip_item=true
            break
        fi
    done

    # Skip the item if it is in the excluded subdirectories list
    if [ "$skip_item" = true ]; then
        continue
    fi

    # If the item is a directory, we'll use '-r' option for recursive copy
    if [[ -d "$item" ]]; then
        cp -r "$item" "$DEST_DIR/"
    else
        cp "$item" "$DEST_DIR/"
    fi
done

echo "Synchronization complete!"

