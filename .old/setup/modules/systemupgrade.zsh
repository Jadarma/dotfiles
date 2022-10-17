#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Full System Upgrade
#
# Simple module that synchronizes pacman.
# Recommended as a first step.
#
# Also enables a few useful settings such as:
# - Multicore compilation for faster installs.
# - Pacman color output.
# - Enable multilib repository (optional).
# ---------------------------------------------------------------------------------------------------------------------
source 'setup/modules/_modulebase.zsh' && moduleInit 'System Upgrade' || exit 126

info 'Configuring pacman.'

debug 'Enabling multicore compilation.'
sed -Ei "s/^#MAKEFLAGS=\"-j[0-9]+\"$/MAKEFLAGS=\"-j$(nproc)\"/" /etc/makepkg.conf ||
  warn 'Could not enable multicore compilation.'

debug 'Enabling pacman color output.'
sed -i 's/^#Color$/Color/' /etc/pacman.conf ||
  warn 'Could not enable pacman color output.'

# shellcheck disable=SC2015
[[ "$PACMAN_MULTILIB" == 'true' ]] &&
  debug 'Enabling multilib repository.' &&
  sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf ||
  fail 'Could not enable multilib repository.'

info 'Performing a full system update.'
pacman -Syyu --noconfirm || fail 'Failed to upgrade system.'

moduleDone
