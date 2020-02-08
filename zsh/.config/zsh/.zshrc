
# Load plugins
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
