#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Keymap
#
# Sets the default system keyboard layouts.
# X11 should already have been installed.
#
# @see https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Setting_keyboard_layout for possible values.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Keymap' || exit 126

# Only the layout is strictly required. Models, variants, and options have default values.
requireConfig KB_LAYOUT

info "Setting default keyboard layouts."
localectl --no-convert set-x11-keymap "$KB_LAYOUT" "$KB_MODEL" "$KB_VARIANT" "$KB_OPTIONS" ||
  fail "Could not set keyboard layouts."

moduleDone
