#!/bin/sh
# -----------------------------------------------------------------------------
# Screen layout for my main machine, JadarmaPC
# Simple triple 1080p displays in landscape.
# -----------------------------------------------------------------------------
xrandr \
  --output HDMI-1 --off \
  --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate normal --primary \
  --output DP-3 --mode 1920x1080 --pos 3840x0 --rotate normal \
