#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Dotfiles
#
# Copies all dotfiles from 'source' to the INSTALL_USER's home.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Dotfiles' || exit 126

requireConfig INSTALL_USER

info "Copying over dotfiles."
rsyncUser "./source/" "/home/$INSTALL_USER/"

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

info 'Setting safe permissions for sensitive directories.'
find "/home/$INSTALL_USER/.local/share/gnupg" -type d -exec chmod 700 {} \;
find "/home/$INSTALL_USER/.local/share/gnupg" -type f -exec chmod 600 {} \;
find "/home/$INSTALL_USER/.ssh" -type d -exec chmod 700 {} \;
find "/home/$INSTALL_USER/.ssh" -type f -exec chmod 600 {} \;

info "Copying over dotfiles."
rsyncUser "./" "/home/$INSTALL_USER/docs/repo/dotfiles/" || warn "Could not save dotfiles copy."

moduleDone
