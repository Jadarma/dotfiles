#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# LESS COLOR
#
# Sets the required environment variables to make `less` and `man` pages colorized.
# ---------------------------------------------------------------------------------------------------------------------

export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESSHISTFILE=-
