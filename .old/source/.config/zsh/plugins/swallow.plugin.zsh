#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# WINDOW SWALLOWING
#
# For interactive sessions only, enables window swallowing, which hides the terminal emulator while spawning another
# window, such is the case when launching applications from the terminal.
#
# You can swallow any command, by calling it via the `swallow` function.
# For commands you use often, consider defining them as an alias instead.
# ---------------------------------------------------------------------------------------------------------------------

function swallow() {
  ID=$(xdo id)
  xdo hide
  "$@" >/dev/null
  STATUS=$?
  xdo show "$ID"
  return $STATUS
}

alias sxiv='swallow sxiv'
alias idea='swallow idea'
alias mpv='swallow mpv --player-operation-mode=pseudo-gui'
