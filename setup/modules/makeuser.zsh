#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Make User
#
# If the INSTALL_USER exists, does nothing.
# Otherwise, creates the user and their home directory.
# This user will also be part of the wheel administrator group.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'Make User' || exit 126

# If user exists, skip this module.
if id -u "$INSTALL_USER" &> /dev/null; then
  info "User '$INSTALL_USER' already exists. Skipping module."
  moduleDone
  exit 0
fi

debug "User '$INSTALL_USER' not found. Creating."
useradd -m -G wheel -s /bin/zsh "$INSTALL_USER" || moduleFail "Could not create user."
debug "Removing bash junk from user home."
rm -v /home/"$INSTALL_USER"/.bash*
debug "Enforcing permissions on home dir."
chmod -R 700 "/home/$INSTALL_USER"
chown -R "$INSTALL_USER:$INSTALL_USER" "/home/$INSTALL_USER"

info "$MAGENTA Please set a password for the user:"
while ! passwd "$INSTALL_USER"; do
  info "Passwords did not match, try again."
done

moduleDone
