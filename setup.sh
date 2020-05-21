#!/bin/zsh
# -----------------------------------------------------------------------------
# Jadarma's Dotfiles Install Script
#
# This script assumes you already have a minimal install of Arch Linux and you
# are running it from the dotfile directory.
# -----------------------------------------------------------------------------

# Create user directories.
DIRS=('.local' '.local/share' '.cache' '.config' '.ssh'
  'desktop' 'docs' 'docs/templates' 'dl' 'public' 'media'
  'media/music' 'media/pictures' 'media/pictures/screenshots' 'media/videos')

for dir in $DIRS; do
  mkdir -p "$HOME/$dir"
done

# Restrict permissions
chmod -R 700 "$HOME"
chmod -R 744 "$HOME/public"

# Stow dotfiles.
stow -v -t "$HOME" alacritty bspwm dunst font gtk hosts lock picom polybar \
  resources rofi scripts sxhkd vis xdg xorg zsh

# Create alias for .profile, because of LightDM.
ln -sf "$HOME/.zprofile" "$HOME/.profile"

# Source env variables for this install script as well
# shellcheck source=$HOME/.zprofile
. "$HOME/.zprofile"

# Install dependencies
echo "Installing dependencies.."
sed -e '/^[[:space:]]*#/d' pkglist.txt |
  sed -E "s/^([a-z0-9-]+)\s*#.*$/\1/" |
  yay -S --needed -
