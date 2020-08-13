# Install Guide {docsify-ignore-all}
---

This guide provides all the steps required for a production ready installation, complete with (almost) full disk
encryption and logical volume management.
If these are not features you need, or are planning to just install on a virtual machine, you might be better off
following the standard [installation guide](https://wiki.archlinux.org/index.php/Installation_guide).

Before you proceed, take note of the following:
* This installation process is _opinionated_, because it is just the way I do it, not the only way.
* Unfortunately it uses `systemd-boot` as a bootloader...
  I know, I hate it too, but it works better than GRUB for me.

## Table of Contents:
* [1. Installation Media](install_guide/10_InstallationMedia)
    * [1.1 Get an Arch ISO](install_guide/10_InstallationMedia#_11-get-an-arch-iso)
    * [1.2 Check UEFI](install_guide/10_InstallationMedia#_12-check-uefi)
    * [1.3 Check Internet Connection](install_guide/10_InstallationMedia#_13-check-internet-connection)
    * [1.4 Sync System Clock](install_guide/10_InstallationMedia#_14-sync-system-clock)
    * [1.5 Sync Pacman Mirrors](install_guide/10_InstallationMedia#_15-sync-pacman-mirrors)
* [2. Disk Formatting](install_guide/20_DiskFormatting)
    * [2.1 Secure Wipe (Optional)](install_guide/20_DiskFormatting#_21-secure-wipe-optional)
    * [2.2 Partitioning](install_guide/20_DiskFormatting#_22-partitioning)
    * [2.3 LUKS Encryption](install_guide/20_DiskFormatting#_23-luks-encryption)
    * [2.4 LVM Partitioning](install_guide/20_DiskFormatting#_24-lvm-partitioning)
    * [2.5 Filesystem Formatting](install_guide/20_DiskFormatting#_25-filesystem-formatting)
* [3. Base Installation](install_guide/30_BaseInstallation)
    * [3.1 Mounting Volumes](install_guide/30_BaseInstallation#_31-mounting-volumes)
    * [3.2 Bootstrapping](install_guide/30_BaseInstallation#_32-bootstrapping)
    * [3.3 Locale and Timezones](install_guide/30_BaseInstallation#_33-locale-and-timezones)
    * [3.4 Hostname](install_guide/30_BaseInstallation#_34-hostname)
    * [3.5 Root Password](install_guide/30_BaseInstallation#_35-root-password)
    * [3.6 Initramfs](install_guide/30_BaseInstallation#_36-initramfs)
    * [3.7 Boot Loader](install_guide/30_BaseInstallation#_37-boot-loader)
    * [3.8. Unmount and Reboot](install_guide/30_BaseInstallation#_38-unmount-and-reboot)
* [4. Post Installation](install_guide/40_PostInstallation)
    * [4.1 Network Configuration](install_guide/40_PostInstallation#_41-network-configuration)
    * [4.2 ZSH](install_guide/40_PostInstallation#_42-zsh)
    * [4.3 User Accounts](install_guide/40_PostInstallation#_43-user-accounts)
    * [4.4 AUR Helper](install_guide/40_PostInstallation#_44-aur-helper)
* [5. Dotfiles Setup](install_guide/50_DotfilesSetup)
    * [5.1 Clone the Repository](install_guide/50_DotfilesSetup#_51-clone-the-repository)
    * [5.2 Setup Script](install_guide/50_DotfilesSetup#_52-setup-script)
    * [5.3 Installation Complete](install_guide/50_DotfilesSetup#_53-installation-complete)

---

> [!WARNING]
> This guide is _not_ a replacement for reading the manual.
> It tries to hold your hand while still providing valuable insights, but it's always a good idea to also follow the
> links to the official documentation when in doubt.
> When in doubt, please consult the official documentation over at the
> [Arch Wiki](https://wiki.archlinux.org/index.php/installation_guide).
> It gives you more details and warnings over what can go wrong and how to prevent it.