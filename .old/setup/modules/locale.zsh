#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Locales
#
# Sets up the locale, time zone, and language for this system.
# Configurable by dotinstall.conf.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Locale' || exit 126

requireConfig LOCALTIME LANGUAGE LOCALES

debug "Updating system clock."
timedatectl set-ntp true || warn 'Could not enable ntp.'
hwclock --systohc --utc || warn 'Could not set hwclock to UTC.'

debug "Setting timezone to '$LOCALTIME'"
ln -sf "/usr/share/zoneinfo/$LOCALTIME" /etc/localtime || warn 'Failed to set timezone.'

debug "Setting language to '$LANGUAGE'"
echo "LANG=$LANGUAGE" > /etc/locale.conf || warn 'Failed to set language.'

# shellcheck disable=SC2153 #LOCALES is defined.
for LOCALE in "${LOCALES[@]}"; do
  sed -i "/$LOCALE/s/^#//g" /etc/locale.gen
done
locale-gen || warn 'Failed to generate locales.'

moduleDone
