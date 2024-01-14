#!/usr/bin/env bash

# Define directories to be searched
dirs=(
    ~/.config
    ~/Programming
    ~/Programming/Web
    ~/Programming/GameDev
    ~/Programming/Tools
    ~/Programming/Misc
    )

# Check if a command-line argument is provided
if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Find subdirectories within the specified directories and use fzf for selection
    selected=$(find "${dirs[@]}" -mindepth 1 -maxdepth 1 -type d | fzf)
fi

# Exit if no directory is selected
if [[ -z $selected ]]; then
    exit 0
fi

# Process the selected directory name
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# Handle tmux session creation and switching
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

