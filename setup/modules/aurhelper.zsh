#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# AUR Helper
#
# Makes sure 'paru' the AUR helper is available on the system.
# If not, installs it with the INSTALL_USER, which should be created by now.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'AUR Helper' || exit 126

requireConfig INSTALL_USER

# If paru is already installed, skip.
PARU_VERSION=$(pacman -Q paru 2>/dev/null)
[[ -n "$PARU_VERSION" ]] && {
  debug "$PARU_VERSION already installed."
  moduleDone
  exit 0
}

debug "Installing 'paru' as $INSTALL_USER..."
PARU_DIR='/tmp/paru-bin'
rm -rf "$PARU_DIR" >/dev/null # Cleanup in case of previous failed execution, just in case.
git clone https://aur.archlinux.org/paru-bin.git "$PARU_DIR" || fail 'Failed to download.'
chmod 777 "$PARU_DIR"
cd "$PARU_DIR" || fail 'Failed to cd into build directory.'
sudo -u "$INSTALL_USER" makepkg --noconfirm -si || fail 'Failed to makepkg paru.'
cd "$REPO_DIR" || warn 'Failed to cd back into the repo dir.'
rm -rf "$PARU_DIR" || warm "Could not clean up '$PARU_DIR'. Manual cleanup required."

moduleDone
