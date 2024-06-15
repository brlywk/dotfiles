# set zinit dir
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

# Check if already installed, if not... install
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

##### Plugin
# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# Replace tab completion suggestions with fzf
zinit light Aloxaf/fzf-tab

# Required by zinit documentation (if zinit is sourced after compinit)
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
