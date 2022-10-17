# ---------------------------------------------------------------------------------------------------------------------
# ZSH RESOURCE CONFIGURATION
#
# This file will be sourced by all interactive shells (most commonly the ones
# you type in). This is where plugins, themes and the like are defined.
# ---------------------------------------------------------------------------------------------------------------------

# Load Plugins
for plugin in $ZDOTDIR/plugins/*.plugin.zsh; do
    source "$plugin"
done

# Command Completion
mkdir -p --mode=700 "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# History
HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
HISTSIZE=50000
SAVEHIST=10000

eval "$(starship init zsh)"
