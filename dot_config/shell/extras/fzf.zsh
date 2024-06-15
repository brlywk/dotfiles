# set fzf colors to tokyonight "night"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# create fzf enabled history search
fzf-history-widget() {
    BUFFER=$(fc -l -n 1 | fzf --height 40% --reverse --tac) && CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N fzf-history-widget

# enable history search with fzf
bindkey "^r" fzf-history-widget
