#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# ZSH ENVIRONMENT
#
# This file will always be sourced by ZSH on every shell launch.
# This is where you define "mutable" environment variables that can change between shell launches.
# ---------------------------------------------------------------------------------------------------------------------

# Programs
export TERMINAL='alacritty'
export FILE='pcmanfm'
export EDITOR='nvim'
export BROWSER='firefox'
export READER='zathura'

# Path with all the custom scripts from `$HOME/.local/bin/`
export PATH="$PATH:$(du -a "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Home Dir Cleanup
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/"

# Less Pager Colors
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESSHISTFILE=-
