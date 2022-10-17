#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# EXA CONFIGURATIONS
#
# Exa is a modern `ls` replacement written in Rust.
# @see https://the.exa.website/
# ---------------------------------------------------------------------------------------------------------------------

# Basic shorthands: l + a for hidden files, l for detail view, t for tree view.
alias l='exa'
alias la='l -a'
alias ll='l -l --group-directories-first --time-style=long-iso'
alias lla='ll -a'
alias lt='ll -T -I ".git|node_modules"'
alias lta='lt -a'

# Shows a tree view of current git repo, filtering just the changed files.
# Yes, I am aware of `git status`.
function lg() {
  REPO=$(git rev-parse --show-toplevel)
  [ -z "$REPO" ] && return 1
  lta --git --color=always "$REPO" | awk -e '$6 !~ /--|I/ { print }'
}

# Some color overrides.
export EXA_COLORS="da=0"

