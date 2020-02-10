# -----------------------------------------------------------------------------
# ZSH ENVIRONMENT
#
# This file will always be sourced by ZSH. This is where you define "mutable"
# environment variables that can change between shell launches. They can also
# be defined in "$HOME/.profile" but that requires a logout for changes to take
# effect.
#
# Do not source ZSH prompts, plugins and other configuration here! Those go in
# the "$ZDOTDIR/.zshrc", that is sourced only by interactive shells.
# -----------------------------------------------------------------------------

typeset -U PATH path
path=(
    /bin
    /usr/bin
    /usr/local/bin
    $HOME/.local/bin
    $HOME/.local/bin/bspwm
    $HOME/.local/bin/scripts
)
export PATH
