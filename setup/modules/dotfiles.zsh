#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Dotfiles
#
# Copies all dotfiles from 'source' to the INSTALL_USER's home.
# ---------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1090
source "$REPO_DIR/setup/modules/_modulebase.zsh"
# shellcheck disable=SC2034
MODULE='Dotfiles'
moduleInit

info "Copying over dotfiles."
rsync -rv "$REPO_DIR/source/" "/home/$INSTALL_USER/"

debug "Updating user directories."
sudo -u "$INSTALL_USER" xdg-user-dirs-update

moduleDone
