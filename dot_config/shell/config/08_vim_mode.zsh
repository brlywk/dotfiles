# update prompt based on vim mode being enabled
function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
        (vicmd)      PROMPT='%F{magenta}❮%f ' ;;
        (main|viins) PROMPT='%F{magenta}❯%f ' ;;
        (*)          PROMPT='%F{magenta}❯%f ' ;;
    esac
    zle reset-prompt
}

# bind widget to the right key
zle -N zle-line-init
zle -N zle-keymap-select
