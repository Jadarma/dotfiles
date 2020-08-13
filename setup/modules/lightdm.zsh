#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# LightDM
#
# Configures LightDM with the Slick Greeter.
# Assumes the lightdm, lightdm-slick-greeter, and the GTK themes are already installed on the system.
# ---------------------------------------------------------------------------------------------------------------------
# shellcheck disable=SC1090
source "$REPO_DIR/setup/modules/_modulebase.zsh"
# shellcheck disable=SC2034
MODULE='LightDM'
moduleInit

info "Setting up display manager."

mkdir -p /usr/share/backgrounds
#cp manjarowatch.png /usr/share/backgrounds || warn "Failed to copy background image resource."
cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm-original.conf || warn "Couldn't backup the original lightdm conf."
cp "$REPO_DIR/setup/resources/lightdm.conf" /etc/lightdm || error "Failed to copy lightdm.conf"
cp "$REPO_DIR/setup/resources/slick-greeter.conf" /etc/lightdm || error "Failed to copy slick-greeter.conf."

info "Enabling light-dm service..."
systemctl --no-ask-password enable lightdm || warn "Could not enable lightdm service. Manual intervention required."

moduleDone
