# Installation Guide
---

This guide provides all the steps required for a production ready installation, complete with (almost) full disk
encryption and logical volume management.
If these are not features you need, or are planning to just install on a virtual machine, you might be better off
following the standard [installation guide](https://wiki.archlinux.org/index.php/Installation_guide).

Before you proceed, take note of the following:

* This installation process is _opinionated_, because it is just the way I do it, not the only way.
* Unfortunately it uses `systemd-boot` as a bootloader...
  I know, I hate it too, but it works better than GRUB for me.

---

* [1. Installation Media](../10_InstallationMedia)
    * [1.1 Get an Arch ISO](../10_InstallationMedia#11-get-an-arch-iso)
    * [1.2 Check UEFI](../10_InstallationMedia#12-check-uefi)
    * [1.3 Check Internet Connection](../10_InstallationMedia#13-check-internet-connection)
    * [1.4 Sync System Clock](../10_InstallationMedia#14-sync-system-clock)
    * [1.5 Sync Pacman Mirrors](../10_InstallationMedia#15-sync-pacman-mirrors)
* [2. Disk Formatting](../20_DiskFormatting)
    * [2.1 Secure Wipe (Optional)](../20_DiskFormatting#21-secure-wipe-optional)
    * [2.2 Partitioning](../20_DiskFormatting#22-partitioning)
    * [2.3 LUKS Encryption](../20_DiskFormatting#23-luks-encryption)
    * [2.4 LVM Partitioning](../20_DiskFormatting#24-lvm-partitioning)
    * [2.5 Filesystem Formatting](../20_DiskFormatting#25-filesystem-formatting)
* [3. Base Installation](../30_BaseInstallation)
    * [3.1 Mounting Volumes](../30_BaseInstallation#31-mounting-volumes)
    * [3.2 Bootstrapping](../30_BaseInstallation#32-bootstrapping)
    * [3.3 Network Access](../30_BaseInstallation#33-network-access)
    * [3.4 Root Password](../30_BaseInstallation#34-root-password)
    * [3.5 Initramfs](../30_BaseInstallation#35-initramfs)
    * [3.6 Boot Loader](../30_BaseInstallation#36-boot-loader)
    * [3.7. Unmount and Reboot](../30_BaseInstallation#37-unmount-and-reboot)
* [4. Dotfiles Setup](../40_DotfilesSetup)
    * [4.1 Clone the Repository](../40_DotfilesSetup#41-clone-the-repository)
    * [4.2 Setup Script](../40_DotfilesSetup#42-setup-script)
    * [4.3 Installation Complete](../40_DotfilesSetup#43-installation-complete)

---

!!! warning
    This guide is _not_ a replacement for reading the manual.
    It tries to hold your hand while still providing valuable insights, but it's always a good idea to also follow the
    links to the official documentation when in doubt.
    When in doubt, please consult the official documentation over at the
    [Arch Wiki](https://wiki.archlinux.org/index.php/installation_guide).
    It gives you more details and warnings over what can go wrong and how to prevent it.
