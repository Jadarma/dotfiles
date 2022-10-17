#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# Z PROFILE
#
# Runs on login, used to autostart graphical sessions and set session-wide environment variables.
# ---------------------------------------------------------------------------------------------------------------------

if [ -z $DISPLAY ] && [ "$(tty)" = '/dev/tty1' ]; then
	export XDG_CURRENT_DESKTOP='sway'
	export GTK_THEME='Adapta-Nokto-Eta'
	exec sway
fi
