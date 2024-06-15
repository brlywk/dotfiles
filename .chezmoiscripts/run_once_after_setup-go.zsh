#!/bin/zsh

# Check if go directory exists and create it
if [ ! -d "$HOME/.go" ]; then
    mkdir -p "$HOME/.go"
fi

go env -w GOPATH=$HOME/.go
