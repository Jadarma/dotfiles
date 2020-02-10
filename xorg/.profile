# -----------------------------------------------------------------------------
# PROFILE
#
# Runs on login. This is where environmental variables are set.
# Note that the $PATH variable is set in the ZSH config in `$ZDOTDIR/.zshenv`.
# -----------------------------------------------------------------------------

# XDG User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Default Programs
export TERMINAL="st"
export FILE="pcmanfm"
export EDITOR="vscodium"
export BROWSER="brave"

# Other
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME="qt5ct"
