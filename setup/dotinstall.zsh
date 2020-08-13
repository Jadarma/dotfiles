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

# Require root privileges. --------------------------------------------------------------------------------------------
[[ $EUID == 0 ]] || {
  printf 'Installation needs to be done as root.\n'
  exit 1
}

# Initialize the DotInstall module. -----------------------------------------------------------------------------------
source setup/modules/_modulebase.zsh || {
  printf 'Could not initialize module.\nAre you sure you are running the script from the repository root?\n'
  exit 1
}
# shellcheck disable=SC2034 # The variable is used by functions defined in module-base.
MODULE='DotInstall'
moduleInit

# Validate configurations. --------------------------------------------------------------------------------------------
debug 'Validating dotinstall.conf'
debug "$(pwd)"
source setup/conf/dotinstall.conf ||
  moduleFail 'Setup configuration missing.\nAre you sure you are running the script from the repository root?'

[[ "$(pwd)" == "$REPO_DIR" ]] || moduleFail 'Invalid config: The REPO_DIR does not match current directory.'
export REPO_DIR

[[ -n "$INSTALL_USER" ]] || moduleFail 'Invalid config: No install user defined.'
USER_ID=$(id -u "$INSTALL_USER" 2>/dev/null)
[[ -n "$USER_ID" && "$USER_ID" -lt 1000 ]] && moduleFail "Invalid config: Install user cannot be a system user."
unset USER_ID
export INSTALL_USER

# shellcheck disable=SC2153 # The variable is defined and sourced by setup.conf
[[ -n "$MODULES" ]] || moduleFail 'Invalid config: Missing module list.'
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

userConfirm "Are you sure you agree to the risks?" || exit 130

# Loop over the modules. ----------------------------------------------------------------------------------------------
debug 'Adding temporary NOPASSWD modifier to sudoers.'
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dotfile_install_tmp

# shellcheck disable=SC2153 # The variable is defined and sourced by setup.conf
for SUBMODULE in $MODULES; do
  MODULE_PATH="./conf/modules/$SUBMODULE.zsh"
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
