#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# AUR Helper
#
# Makes sure 'yay' the AUR helper is available on the system.
# If not, installs it with the INSTALL_USER, which should be created by now.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'AUR Helper' || exit 126

requireConfig INSTALL_USER

# If yay is already installed, skip.
YAY_VERSION=$(pacman -Q yay 2>/dev/null)
[[ -n "$YAY_VERSION" ]] && {
  debug "$YAY_VERSION already installed."
  moduleDone
  exit 0
}

debug "Installing 'yay' as $INSTALL_USER..."
YAY_GIT='/tmp/yay'
rm -rf "$YAY_GIT" >/dev/null # Cleanup in case of previous failed execution, just in case.
cd /tmp || fail 'Failed to cd into the temp folder.'
curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz || fail 'Failed to download sources.'
tar -xf yay.tar.gz || fail 'Failed to unpack sources.'
chmod 777 "$YAY_GIT"
cd "$YAY_GIT" || fail 'Failed to cd into yay git directory.'
sudo -u "$INSTALL_USER" makepkg --noconfirm -si || fail 'Failed to makepkg yay.'
cd "$REPO_DIR" || warn 'Failed to cd back into the repo dir.'
rm -rf "$YAY_GIT" || warm 'Could not clean up yay-repo in /tmp/yay-git. Manual cleanup required.'

moduleDone
