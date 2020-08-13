#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Full System Upgrade
#
# Simple module that synchronizes pacman.
# Recommended as a first step.
# ---------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1090
source "$REPO_DIR/setup/modules/_modulebase.zsh"
# shellcheck disable=SC2034
MODULE='System Update'
moduleInit

info "Performing a full system update."
pacman -Syyu || warn "Failed to upgrade system."

moduleDone
