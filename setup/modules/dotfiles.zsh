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
rsyncUser "$REPO_DIR/source/" "/home/$INSTALL_USER/"

info "Creating user directories."
DIRS=(
  'desktop' 'docs' 'dl' 'music' 'pictures' 'videos' 'public' 'templates'
  'docs/repo' 'docs/repo/dotfiles' 'pictures/screenshots'
  '.ssh' '.ssh/environment'
)
# shellcheck disable=SC2034
DIR_PATHS=$(printf "/home/$INSTALL_USER/%s " "${DIRS[@]}")
# shellcheck disable=SC2153
# shellcheck disable=SC2086
install -dv -o "$INSTALL_USER" -g "$INSTALL_USER" -m 750 ${=DIR_PATHS} || warn "Could not create xdg-user-dirs."

info "Copying over dotfiles."
rsyncUser "$REPO_DIR/" "/home/$INSTALL_USER/docs/repo/dotfiles/" || warn "Could not save dotfiles copy."

moduleDone
