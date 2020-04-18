# -----------------------------------------------------------------------------
# PROFILE
#
# Runs on login. This is where environmental variables are set.
# -----------------------------------------------------------------------------

# Path with all the custom scripts from `$HOME/.local/bin/`
export PATH="$PATH:$(du -a "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:$//')"

# XDG User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Default Programs
export TERMINAL="alacritty"
export FILE="pcmanfm"
export EDITOR="nvim"
export BROWSER="brave"
export READER="zathura"

# Home Directory Cleanup
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Other
export QT_QPA_PLATFORMTHEME="qt5ct"
export LESSHISTFILE=-
