#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Full System Upgrade
#
# Simple module that synchronizes pacman.
# Recommended as a first step.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'System Upgrade' || exit 126

info "Performing a full system update."
pacman -Syyu --noconfirm || warn "Failed to upgrade system."

moduleDone
