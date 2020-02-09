# XDG User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Path Variables
typeset -U PATH path
path=(
    /bin
    /usr/bin
    /usr/local/bin
    $HOME/.local/bin
    $HOME/.local/bin/bspwm
)
export PATH