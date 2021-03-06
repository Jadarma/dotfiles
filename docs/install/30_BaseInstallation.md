# Base Installation
---

This section covers bootstrapping the system so that it can boot and function on its own.

## 3.1. Mounting Volumes

We need to mount our volumes before we can bootstrap and configure the installation.
All the volumes need to be mounted in `/mnt`, to their appropriate mount points.

```shell
mount /dev/mapper/volume-root /mnt
mkdir /mnt/boot
mount /dev/sdx1 /mnt/boot
mkdir /mnt/home
mount /dev/mapper/volume-home /mnt/home
swapon /dev/mapper/volume-swap
```

## 3.2 Bootstrapping

Bootstrap the base system onto the disk.
This might take a while depending on your connection. 

```shell
pacstrap /mnt base base-devel linux linux-firmware neovim zsh git
```

!!! tip
    You can replace `linux` with whatever [kernel](https://wiki.archlinux.org/index.php/kernel) you want.
    For example, consider `linux-zen` for better performance in everyday use.

!!! note
    Install your text editor of choice.
    This guide shall use `nvim`, but feel free to use `vi`, `vim`, `nano` or whatever else.

Next, generate the [fstab](https://wiki.archlinux.org/index.php/Fstab) file.
While the `-U` option is not really required for LVM, I still prefer using UUIDs.

```shell
genfstab -Up /mnt > /mnt/etc/fstab
```

Now `chroot` into the system.
Don't worry, the prompt change is expected.

```shell
arch-chroot /mnt
```

## 3.3 Network Access

We are currently getting our network connection from the Arch ISO.
If we boot into the actual installation, we won't have any internet connection.

```shell
pacman -S networkmanager inetutils
systemctl enable NetworkManager
```

If your device does not have Wi-Fi capabilities, you may skip to the next step.

For Wi-Fi, I recommend going with the newer `iwd`, which is what we have used in the Arch ISO.

```shell
pacman -S iwd
systemctl enable iwd
```

Next, configure NetworkManager to 
[use iwd as a backend](https://wiki.archlinux.org/index.php/NetworkManager#Using_iwd_as_the_Wi-Fi_backend).

Simply create the `/etc/NetworkManager/conf.d/wifi_backend.conf` file with the following contents:

```text
[device]
wifi.backend=iwd
```

That's it.
You will now be able to have network access from your own machine after installation.

!!! note
    NetworkManager takes control of `iwd`, so you cannot use `iwctl` to connect to wireless networks anymore.
    Instead, use `nmcli`, as [described on the Wiki](https://wiki.archlinux.org/index.php/NetworkManager#Usage).

## 3.4 Root Password

Set the password for the `root` account.

```shell
passwd
```

It's also a good idea to enable the wheel group, so you can run commands as root with other administrator users after
the installation.

In `/etc/sudoers`, uncomment the following lines. (Use `wq!` to bypass readonly file warning.)

```text
%wheel ALL=(ALL) ALL
```

## 3.5 Initramfs

Because we are using 
[LVM on LUKS](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS), we need to add
the `encrypt` and `lvm2` hooks into `mkinitcpio.conf`.

```shell
pacman -S lvm2
nvim /etc/mkinitcpio.conf
```

Change the hooks line to:

```
HOOKS=(base udev autodetect modconf block keyboard keymap encrypt lvm2 filesystems fsck)
```

Then build the `initramfs` image by running:

```shell
mkinitcpio -p linux
```

!!! note
    If when bootstrapping with `pacstrap` you installed a custom kernel, that same kernel should be passed
    to the `-p` option _(e.g. `mkinitcpio -p linux-zen`)_.

## 3.6 Boot Loader

We can now install a [boot loader](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader).
In this guide, we will be using [`systemd-boot`](https://wiki.archlinux.org/index.php/Systemd-boot).

First, install the [microcode](https://wiki.archlinux.org/index.php/Microcode) depending on your system's CPU.

```shell
pacman -S amd-ucode
```

Install the boot loader.

```shell
bootctl install
```

Edit the configuration file at `/boot/loader/loader.conf` with the following:

```
default arch
timeout 3
editor 0
```

This achieves the following:
* Sets `arch` as the default entry _(to be created soon)_.
* Offers the user three seconds to select another entry before booting the default.
* Does not allow the kernel parameters to be edited.

Now we need to add an entry for `arch`.

```shell
nvim /boot/loader/entries/arch.conf
```

Follow the template:

```
title Arch Linux
linux /vmlinuz-linux
initrd /amd-ucode.img
initrd /initramfs-linux.img
options cryptdevice=UUID={UUID}:volume root=/dev/mapper/volume-root quiet rw
```

You will need to adjust it as follows:

* The `title` can be whatever you want displayed in the boot menu.
* Change to your relevant `*-ucode.img` depending on your system.
* Again, a custom kernel will result in a different linux and init image.
  (e.g. `/vmlinuz-linux-zen` and `/initramfs-linux-zen.img`) 
* The `{UUID}` should be replaced by the block device ID of the encrypted partition (`/dev/sdx2`), which you can get by
  running `blkid /dev/sdx2`.

!!! tip
    If using `vim`, you can insert the output of the `blkid` command right in the editor by typing:
    `^ESC :r! blkid /dev/sdx2`

## 3.7. Unmount and Reboot

We no longer need the Arch ISO as the base system is already configured.
Unmount the volume, turn off the swap, close the LVM and LUKS container, and reboot.

```shell
exit # Or Ctrl+D to get out of `chroot`.
umount -R /mnt
swapoff /dev/mapper/volume-swap
vgchange -a n volume
cryptsetup close /dev/mapper/lvm
reboot
```
