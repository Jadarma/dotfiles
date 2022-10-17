# ---------------------------------------------------------------------------------------------------------------------
# ZSH ENVIRONMENT
#
# This file will always be sourced by ZSH. This is where you define "mutable" environment variables that can change
# between shell launches. They can also be defined in "$HOME/.zprofile" but that requires a logout for changes to take
# effect.
#
# Do not source ZSH prompts, plugins and other configuration here!
# Those go in the "$ZDOTDIR/.zshrc", that is sourced only by interactive shells.
# ---------------------------------------------------------------------------------------------------------------------

# Default Programs
export TERMINAL="alacritty"
export FILE="pcmanfm"
export EDITOR="nvim"
export BROWSER="brave"
export READER="zathura"

# Less Pager Config
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESSHISTFILE=-
