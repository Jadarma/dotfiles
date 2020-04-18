# Arch Linux Fresh Install
To be able to run my dotfiles, you first need an operating system.
I recommend using Arch Linux, but Arch-based distributions also work;
this repository was developed on Manjaro at first.

?> **NOTE:** The Arch install process heavily depends on your setup, and there
is no silver bullet.
This guide is for a minimal install on a _virtual machine_ for testing purposes.

!> **WARNING:** This guide is _not_ a replacement for reading the manual.
When setting up your own machine, please consult the official documentation over
at the [Arch Wiki](https://wiki.archlinux.org/index.php/installation_guide).
It gives you more details and warnings over what can go wrong and how to 
prevent it.

[Download](https://www.archlinux.org/download/) the latest Arch ISO.
If you are installing on a VM, no further action is required.
Otherwise, prepare a USB stick and follow the
[guide](https://wiki.archlinux.org/index.php/USB_flash_installation_media).

The following steps assume that you have already booted into the Arch install
ISO on an EFI-capable machine.

- **Update the system clock**

```zsh
timedatectl set-ntp true
```

- **Partition disk**

Your experience may vary.
Proceed at your own risk!
```zsh
fdisk -l # Check your available drives
fdisk /dev/vda # Select the one you'll install on.
```
Using `fdisk`, create the following partitions:
```
/dev/vda1 EFI System Partition 512MB
/dev/vda2 Linux Swap           8GB # (OPTIONAL) For <8GB ram machines. 
/dev/vda3 Linux x86-64 root    <Remaining>
```

- **Format and mount partitions**

```zsh
mkfs.fat -F32 /dev/vda1
mkwap /dev/vda2
mkfs.ext4 /dev/vda3
mount /dev/vda3 /mnt
swapon /dev/vda2
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
```

- **Pacstrap**

Install base packages, text editors, services, etc.
These are my recommendations.
Note that in this snippet I installed `intel-ucode`; you may want to adjust that
if you are running AMD.
```zsh
pacstrap /mnt \
  base base-devel linux linux-firmware \
  neovim man-db man-pages \
  inetutils netctl dhcpcd \
  intel-ucode
```

- **Generate FSTAB**

```zsh
genfstab -U /mnt >> /mnt/etc/fstab
```
You may want to open the file and take note of the UUID of your root partition,
in this case `/dev/vda3`.
We will need it later.

- **Change root**

We can now begin working directly from our installed Arch.
```zsh
arch-chroot /mnt
```

- **Setup timezones and locale**

Replace the variables with your own variants. I recommend using `en_DK` instead
of `en_US` because it uses the ISO8601 date format. _(Good job, Denmark!)_
```zsh
ln -sf /usr/share/zoneinfo/$REGION/$CITY /etc/localtime
hwclock --systohc
echo "en_DK.UTF-8 UTF-8" >> /etc/locale.gen # Or edit the file and uncomment it.
locale-gen
echo "LANG=en_DK.UTF-8" > /etc/locale.conf
```

- **Network configuration**

Configure hosts.
Pick a name wisely.
It can be used to override certain dotfile settings later.

```zsh
echo "$HOSTNAME" > /etc/hostname
nvim /etc/hosts
```
Give it the following contents:

```
127.0.0.1      localhost
::1            localhost
127.0.1.1      $HOSTNAME.localdomain $HOSTNAME
```

- **Set a root password**

Make it a good one.

```zsh
passwd
```

- **Install bootloader**

Because we are using EFI, and Arch using `systemd`, we will be using
`system-dboot`.
If you're looking for other solutions, the 
[wiki](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader) has
you covered.
I would recommend either `systemd-boot` or `GRUB`.

```zsh
bootctl --path=/boot install
nvim /boot/loader/loader.conf
```

Change the default to `arch-*` and save.
```zsh
nvim /boot/loader/entries/arch.conf
```

Write the following, where `$UUID` is the ID of the root partition, `/dev/vda3`.
```
title    Arch Linux
linux    /vmlinuz-linux
initrd   /intel-ucode.img
initrd   /initramfs-linux.img
options  root=UUID=$UUID rw
```

?> **TIP:** If you are using `vim`, you can insert the `$UUID` by running:
`:r! blkid /dev/vda3` and removing the extra information (including the quotes).

!> If you didn't install `intel-ucode`, skip that line.
 
- **Exit and reboot**

Fingers crossed!
```zsh
exit
umount -R /mnt
reboot
```
If everything went well you should boot into the OS.
You have successfully completed a minimal installation of Arch Linux!

[_Next Step: Post Installation_](installation/post_install.md)
