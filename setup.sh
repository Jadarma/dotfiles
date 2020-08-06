#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Jadarma's Dotfiles Install Script
#
# This script assumes you already have a minimal install of Arch Linux and you
# are running it from the dotfile directory.
# ---------------------------------------------------------------------------------------------------------------------

# Install dependencies
echo "Installing dependencies.."
sed -e '/^[[:space:]]*#/d' pkglist.txt |
  sed -E "s/^([a-z0-9-]+)\s*#.*$/\1/" |
  yay -S --needed -

# Stow dotfiles.
stow -v -t "$HOME" alacritty bspwm dunst font gtk hosts lock picom polybar pulseaudio resources rofi scripts spicetify \
  sxhkd sxiv vis xdg zathura zsh

# Create home directories.
DIRS=('.local' '.local/share' '.cache' '.config' '.ssh'
  'desktop' 'docs' 'templates' 'dl' 'public' 'media' 'music' 'pictures' 'videos'
  'docs/repo' 'pictures/screenshots'
)

for dir in $DIRS; do
  mkdir -p "$HOME/$dir"
done

xdg-user-dirs-update
