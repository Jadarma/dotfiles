# 1. Installation Media {docsify-ignore-all}
---

While it is possible to 
[install arch from an existing Linux](https://wiki.archlinux.org/index.php/Install_Arch_Linux_from_existing_Linux),
it is recommended you do a fresh install, since it reduces the variables involved in your install.
This guide assumes you are installing from an Arch ISO loaded from a USB Flash drive.

## 1.1 Get an Arch ISO
To set up the drive, download the latest [Arch Linux ISO](https://www.archlinux.org/download/) and verify the signature
_(Optional)_.\
[Flash](https://wiki.archlinux.org/index.php/USB_flash_installation_medium) it to your drive with `dd`, for example.\
Get the block device name of your USB drive, here `/dev/sdx`.

```shell script
sudo lsblk 
sudo dd if=/path/to/iso of=/dev/sdx bs=4096 status=progress
```

> [!DANGER]
> Selecting the wrong device might lead to you overwriting your own data!

Now plug the drive into the host you wish to install to and boot into the Arch ISO.

## 1.2 Check UEFI

Ensure that your system is UEFI capable.
If the following directory is not empty, it is.

```shell script
ls /sys/firmware/efi
```

## 1.3 Check Internet Connection

If you are using a device with a wired connection, check your connection:

```shell script
ping archlinux.org
```

If you are on a laptop and cannot establish a wired connection, you must first connect to a wireless network.
For this you must use [iwd](https://wiki.archlinux.org/index.php/Iwd#iwctl), which is already present on the ISO.

First, find the name of your wireless interface.
Then, if you're not sure what networks are available, do a scan and take note of the network name _(or SSID)_.
Finally, connect to the network;
you will pe prompted for a password if necessary.

```shell script
iwctl device list                   # > $DEVICE
iwctl station $DEVICE get-networks. # > $SSID
iwctl station $DEVICE connect $SSID
```

Pinging a server should now work.

## 1.4 Sync System Clock

Update your system clock with the following command:

```shell script
timedatectl set-ntp true
```

## 1.5 Sync Pacman Mirrors

In case your ISO was made long ago, it might be that your mirrors are out of date, and `pacman` will struggle to install
some packages.
To update them:

```shell script
pacman -Syy pacman-mirrorlist archlinux-keyring
pacman-key --refresh-keys
mv /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
```

You may now edit the `/etc/pacman.d/mirrorlist` and uncomment the mirrors you wish to use.
Usually you'd want the world-wide mirrors along with a few near your geographical location.
