#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# ZSH SYNTAX HIGHLIGHTING
#
# The commands wirtten in any shell prompt will be syntax highlighted.
# This file makes modifications so that the color scheme used resembles IntelliJ Idea (with Material Oceanic plugin).
#
# If you consider it to be bloat, you can remove all the overrides and leave only the last `source` command.
#
# This requires the `zsh-syntax-highlighting` package to be installed.
# @see https://github.com/zsh-users/zsh-syntax-highlighting
# ---------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC2034

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
