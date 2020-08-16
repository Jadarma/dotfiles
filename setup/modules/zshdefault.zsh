#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# ZSH Default
#
# Sets ZSH as the default shell for root as well as setting it as the interpreter of plain sh scripts.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'ZSH Default' || exit 126

info 'Changing root user shell to zsh.'
chsh -s /bin/zsh || error 'Could not change root shell.'

info 'Linking POSIX sh to zsh.'
ln -sf /bin/zsh /bin/sh || error 'Could not link POSIX sh to zsh.'

moduleDone
