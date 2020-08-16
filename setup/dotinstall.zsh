#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Jadarma's Dotfiles Install Script
#
# The main installation script for my dotfiles.
# This will take a fresh install of Arch Linux and configure it with my personal dotfiles.
#
# Fully automated apart from a disclaimer prompt and the password input for a new user.
# Customisable via the editing of `setup/conf/dotinstall.conf`.
# ---------------------------------------------------------------------------------------------------------------------
source setup/modules/_modulebase.zsh && moduleInit 'DotInstall' || exit 126

# Validate configurations. --------------------------------------------------------------------------------------------
requireConfig INSTALL_USER MODULES

USER_ID=$(id -u "$INSTALL_USER" 2>/dev/null)
[[ -n "$USER_ID" && "$USER_ID" -lt 1000 ]] && moduleFail "Invalid config: Install user cannot be a system user."

debug 'Validation of setup.conf successful.'

# Show disclaimer, get user confirmation before continuing. -----------------------------------------------------------
# shellcheck disable=SC2059 # The interpolated values are color codes, not relevant data.
printf "$GREEN > Jadarma's Dotfiles Install Script! $NORMAL

Welcome! Thank you for trying out my configs.
This script will attempt to bootstrap your installation.

If you haven't already, you can customise the setup process by editing the 'setup/conf/dotinstall.conf' file.
Do be careful, though. :)

Please note that:
 - This script works best and ${UNDERLINE}was intended for fresh installs${NORMAL}!
 - It's dangerous to install for an already existing user. Let the script create it for you to minimise risk.\n\n"

if [[ -n "$USER_ID" ]]; then
  printf "${YELLOW}Warning! User '%s' already exists. Installing over existing users is experimental and potentially\
 dangerous!$NORMAL\n" "$INSTALL_USER"
fi
unset USER_ID

userConfirm "Are you sure you agree to the risks?" || exit 130

# Loop over the modules. ----------------------------------------------------------------------------------------------
debug 'Adding temporary NOPASSWD modifier to sudoers.'
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dotfile_install_tmp

# shellcheck disable=SC2153 # The variable is defined and sourced by setup.conf
for SUBMODULE in $MODULES; do
  MODULE_PATH="./setup/modules/$SUBMODULE.zsh"
  [[ ! -f "$MODULE_PATH" && "$FAIL_ON_MODULE_ERROR" != true  ]] && {
      warn "Could not find module '$SUBMODULE'. Skipping...";
      continue
  }
  if ! zsh "$MODULE_PATH"; then
    [[ "$FAIL_ON_MODULE_ERROR" == true ]] && {
      error "Module '$SUBMODULE' failed."
      break;
    }
  fi
done

debug 'Removing temporary NOPASSWD modifier from sudoers.'
rm -f /etc/sudoers.d/dotfile_install_tmp

moduleDone
