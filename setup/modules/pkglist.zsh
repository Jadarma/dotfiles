#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Package List
#
# Installs all dependencies as specified in the 'setup/conf/pkglist.txt'.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Package List' || exit 126

requireConfig INSTALL_USER

debug 'Importing dependency list.'
PKG_FILE="./setup/conf/pkglist.txt"
[[ -r "$PKG_FILE" ]] || fail 'Cannot install dependencies. Missing pkglist.txt.'

# Reads the pkglist, removing all commented or empty lines and saves list into an array.
PACKAGES=("${(@f)$(sed -E '/^\s*#/d' "$PKG_FILE" | sed -E '/^\s*$/d' | sed -E "s/^([a-z0-9-]+)\s*#.*$/\1/")}")

# If they are already all installed, skip.
sudo -u "$INSTALL_USER" paru -Q "${PACKAGES[@]}" &>/dev/null && {
  debug 'All packages are present!'
  moduleDone
  exit 0
}

debug 'Installing package dependencies.'
# shellcheck disable=SC2128
for PACKAGE in $PACKAGES; do
  debug "Installing $PACKAGE"
  sudo -u "$INSTALL_USER" paru -S --needed --noconfirm "$PACKAGE" || warn "Failed to install $PACKAGE."
done

debug 'Double checking dependencies.'
sudo -u "$INSTALL_USER" paru -Q "${PACKAGES[@]}" 2>/dev/null || warn "Some packages are missing."

moduleDone
