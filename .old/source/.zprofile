# ---------------------------------------------------------------------------------------------------------------------
# Z PROFILE
#
# Runs on login. This is where environment variables that normally would not be changed during the lifetime of the user
# session are declared.
# ---------------------------------------------------------------------------------------------------------------------

# Path with all the custom scripts from `$HOME/.local/bin/`
export PATH="$PATH:$(du -a "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# XDG User Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
mkdir -p "$XDG_CACHE_HOME/dotfiles"

# Home Directory Cleanup
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/"

# Other
export QT_QPA_PLATFORMTHEME="gtk2"
