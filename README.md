# My Dev Configuration

If you've just stumbled upon this configuration: Welcome! 👋

**Important:** If, like me, you are new to NeoVim and are looking for inspiraton, please feel free
to copy as much of my config as you like! I did it like that myself 😄

However, from my own experience, I strongly recommend not to just copy & paste. I will list the
recources I used below, so maybe these can be useful to you and other newbies. It was a lot of
research, experimenting, cursing, rewriting copied code... but it was also a lot of fun!

**Note:**
This is not a complete and exhaustive setup guide. More a list of reminders for myself that are
hopefully also a little bit useful for anyone stumbling onto this repository!

# macOS Setup

Some necessary steps to make everything work when using macOS 🍎

## Installations

- [Wezterm](https://wezfurlong.org/wezterm/)
- [NerdFont](https://www.nerdfonts.com) (JetBrainsMono Nerd Font)
- [Homebrew](https://docs.brew.sh/Installation)
- [Starship](https://starship.rs)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [NeoVim](https://github.com/neovim/neovim/wiki/Installing-Neovim#homebrew-on-macos-or-linux)
- [tmux](https://formulae.brew.sh/formula/tmux)
- [fzf](https://formulae.brew.sh/formula/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [1password CLI](https://developer.1password.com/docs/cli/get-started)

## Setup

- Unassign / uncheck the 'Input Sources Selection': System Settings > Keyboard > Keyboard Shortcuts... > Input Sources
  - Needed as we want to use C-Space in NeoVim
- Reassign CapsLock to Escape: System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys
  - **Note:** This unfortunately doesn't work if you use a Logitech Keyboard and Logitech Options+.

# Resources / Thanks

Here's a list of all the resources I used to cobble together my config. Big thanks to anyone on this list for providing
excellent tutorials or existing configs to read and learn how things work! 🥳

- [kickstart](https://github.com/nvim-lua/kickstart.nvim)
- ThePrimeagen - [0 to LSP: Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
- TJ DeVries - [Neovim config](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- Josean Martinez - [How To Make Your Boring Mac Terminal So Much Better](https://www.youtube.com/watch?v=CF1tMjvHDRA)
- Dreams of Code
  - [The Zen tmux config](https://youtube.com/watch?v=DzNmUNvnB04)
  - [Neovim for Node.js](https://www.youtube.com/watch?v=CVCBHHFXWNE)
- Elijah Manor - [Zero to IDE with LazyVim](https://www.youtube.com/watch?v=N93cTbtLCIM)
- [LazyVim source files](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim)
- [NvChad source files](https://github.com/NvChad/NvChad)
