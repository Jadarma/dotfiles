# Disk Formatting
---

This section only covers partitioning the main drive on which Arch will be installed, for sake of simplicity. If you
have other drives you wish to use, you can handle those here as well, but if they are only for extra storage, and will
not hold system partitions, then you can always configure them later.

To see what drives are available to you, run `lsblk` and find your desired device. The name might differ if you have an
SSD or NVME drive (`nvme0n1`).

This guide will use `/dev/sdx` as the installation drive. Replace all occurrences with your own value.

!!! danger 
    All the data on this drive will be irrevocably destroyed. Make all necessary backups now.

!!! warning
    Be ***extra careful*** not to run the commands in this section on the wrong devices, as it may lead to data
    loss too!

## 2.1 Secure Wipe (Optional)

Since we will be using full disk encryption, in order to reduce the attack vector, it is good practice to first securely
wipe the drive.

!!! note
    Wiping is a bit tricky for solid state drives, and can be skipped if you don't want the hassle.
    If you decide to do it, be sure to read the
    [documentation](https://wiki.archlinux.org/index.php/Solid_state_drive/Memory_cell_clearing).

For general use, zeroing out the drive is enough:

```shell
dd if=/dev/zero of=/dev/sdx bs=1M status=progress
```

If you're feeling paranoid, use [`shred`](https://wiki.archlinux.org/index.php/Securely_wipe_disk#shred) instead.

Depending on the size of your drive, this can take a few _hours_.

## 2.2 Partitioning

We will be using full disk encryption, so we only need two partitions: one for our boot, and the rest of the drive. You
may use any [partitioning tool](https://wiki.archlinux.org/index.php/Partitioning#Partitioning_tools) you desire, here
we will use [`gdisk`](https://wiki.archlinux.org/index.php/GPT_fdisk).

```shell
gdisk /dev/sdx
```

Then do the following:

* View help. (`?`)
* Create a new GPT. (`o`)
* Create a new 550 MB EFI partition. (`n <default> <default> +550M ef00`)
* Create a new LVM partition for the rest of the drive. (`n <default> <default> <default> 8e00`)
* Save the changes and exit. (`w`)

Running `lsblk` again should show the two partitions as `/dev/sdx1` and `/dev/sdx2`.

## 2.3 LUKS Encryption

The drive is cleaned and partitioned. It's time to encrypt it with LUKS.

!!! danger
    Forgetting the password for your LUKS container results in a permanent loss of access to the drive's contents.
    Store it in a safe place, like a password manager.

```shell
cryptsetup -v -y \
  -c aes-xts-plain64 -s 512 -h sha512 -i 4000 --use-random \
  luksFormat --type luks2 /dev/sdx2
```

An explanation of above options:

* `-v` : Verbose, increases output for debugging in case something goes wrong.
* `-y` : Ask for the password interactively, twice, and matches them before proceeding.
* `-c` : Specifies the cypher, in this case `aes-xts-plain64` is the default for the LUKS2 format.
* `-s` : Specifies the key size used by the cypher.
* `-h` : Specifies the hashing algorithm used, `sha256` by default.
* `-i` : Milliseconds to spend processing the passphrase, `2000` by default.
* `--use-random` Specifies the RNG source, another option is `--use-urandom`.
* `luksFormat` : Operation mode that encrypts a partition and sets a passphrase.
* `--type` : Specify the LUKS type to use.
* `/dev/sdx2` : The partition you wish to encrypt.

!!! tip
    You can inspect the LUKS header to check everything OK with `cryptsetup luksDump /dev/sdx2`.
    It is also a good practice to back it up.
    Create a copy with `cryptsetup luksHeaderBackup --header-backup-file /a/path/header.img /dev/sdx2`.
    Do so when it is convenient to save it in another location.

Now, we need to open the LUKS container:

```shell
cryptsetup open --type luks /dev/sdx2 lvm
```

## 2.4 LVM Partitioning

Now we will create our system partitions inside the encrypted LUKS container using
[LVM](https://wiki.archlinux.org/index.php/LVM). This has some advantages, at the cost of another mapping layer:

* Simple and resizable partitions.
* A single key required to unlock all volumes (simplifies the boot process)
* Partition layout invisible when locked.
* An encrypted swap partition allows for easy
  [hibernation](https://wiki.archlinux.org/index.php/Dm-crypt/Swap_encryption#With_suspend-to-disk_support).

Check the LVM disk exists, as mapped earlier.

```shell
ls /dev/mapper/lvm
```

Create a physical volume, and a volume group within it (here called _volume_).

```shell
pvcreate /dev/mapper/lvm
vgcreate volume /dev/mapper/lvm
```

Create the logical partitions you want to use. It's up to you if you want to create a separate home partition. If you
do, decide how much to reserve for your root partition. Recommended size is about 40 GB, with a minimum of 20. I like to
have extra room just in case, so I go for 64 GB. This is LVM, so you can
[resize](https://wiki.archlinux.org/index.php/LVM#Resizing_the_logical_volume_and_file_system_in_one_go)
if needed.

```shell
lvcreate -L16G volume -n swap
lvcreate -L64G volume -n root
lvcreate -l 100%FREE volume -n home
```

## 2.5 Filesystem Formatting

All the partitions are in place, we can now format them with the appropriate filesystems:

```shell
mkfs.fat -F32 /dev/sdx1
mkfs.ext4 /dev/mapper/volume-root
mkfs.ext4 /dev/mapper/volume-home
mkswap /dev/mapper/volume-swap
```
