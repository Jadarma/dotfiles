#!/usr/bin/env zsh
# ---------------------------------------------------------------------------------------------------------------------
# GPG AGENT
#
# Sets the required environment variables for the GPG Agent and launches it if not already running.
# ---------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC2155
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
