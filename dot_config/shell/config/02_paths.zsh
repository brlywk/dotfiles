# Go tools
export PATH=$PATH:$(go env GOPATH)/bin

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/christoph/.bun/_bun" ] && source "/Users/christoph/.bun/_bun"

# Volta
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
