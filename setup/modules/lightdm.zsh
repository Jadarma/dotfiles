#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# LightDM
#
# Configures LightDM with the Slick Greeter.
# Assumes the lightdm, lightdm-slick-greeter, and the GTK themes are already installed on the system.
# ---------------------------------------------------------------------------------------------------------------------
source "setup/modules/_modulebase.zsh" && moduleInit 'LightDM' || exit 126

info "Setting up display manager."

mkdir -p /usr/share/backgrounds
cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm-original.conf || warn "Couldn't backup the original lightdm conf."
cp "$REPO_DIR/setup/resources/manjarowatch.png" /usr/share/backgrounds || warn "Failed to copy login background image."
cp "$REPO_DIR/setup/resources/lightdm.conf" /etc/lightdm || error "Failed to copy lightdm.conf"
cp "$REPO_DIR/setup/resources/slick-greeter.conf" /etc/lightdm || error "Failed to copy slick-greeter.conf."

info "Enabling LightDM service..."
systemctl --no-ask-password enable lightdm || warn "Could not enable LightDM service. Manual intervention required."

moduleDone
