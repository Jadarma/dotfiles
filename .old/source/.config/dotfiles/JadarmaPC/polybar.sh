#!/usr/bin/env sh
# ---------------------------------------------------------------------------------------------------------------------
# Polybar layout for my main machine, JadarmaPC
# Main bar in center monitor, simple bar in side monitors.
# ---------------------------------------------------------------------------------------------------------------------

MONITOR=DP-1 polybar --reload simple &
MONITOR=DP-3 polybar --reload main &
MONITOR=DP-5 polybar --reload simple &
unset MONITOR
