#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Hostname
#
# Sets the machine hostname as well as stubs the /etc/hosts file.
# Warning: This resets the hosts file, so do not enable the module if you have own modifications here.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Hostname' || exit 126

requireConfig HOSTNAME

debug 'Setting hostname.'
echo "$HOSTNAME" > /etc/hostname || fail 'Could not set hostname'

debug 'Updating hosts.'
echo "\
# Static table lookup for hostnames.
# See hosts(5) for details.
127.0.0.1      localhost
::1            localhost
127.0.1.1      $HOSTNAME.localdomain $HOSTNAME
" > /etc/hosts || fail 'Could not stub hosts file.'

moduleDone
