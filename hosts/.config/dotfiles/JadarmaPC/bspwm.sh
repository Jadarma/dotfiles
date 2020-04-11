#!/bin/sh
# -----------------------------------------------------------------------------
# BSPWM desktop layout for my main machine, JadarmaPC
# Three desktops per screen, from left to right: 4,5,6,1,2,3,7,8,9
# -----------------------------------------------------------------------------
bspc monitor DP-1 -d 4 5 6
bspc monitor DP-3 -d 1 2 3
bspc monitor DP-5 -d 7 8 9

feh \
  --no-fehbg \
  --bg-fill \
  --no-xinerama \
  "$XDG_DATA_HOME/dotfiles/images/manjarowatch_triple.png"
