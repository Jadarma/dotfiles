# Post Installation
Now that you have a minimal Arch install, it is time to set up your personal
user account and other minor details.
You may want to personalize this step, so for that reason it is not imposed on
you.
The following steps are what I use.

---
- **Setting up an internet connection**

Chances are your internet connection won't be active by default.
We have installed the necessary packages but have not enabled the service.

```zsh
systemctl enable --now dhcpcd
```

Test your internet connection:
```zsh
ping archlinux.org
```

?> If you are on a laptop, chances are you'll need some extra packages, like
the `wifi-menu` you most certainly used during installation.
If you forgot to install them don't worry! You can simply boot back into the
Arch ISO, set up a network connection, mount your drive then `arch-chroot` to
also install the dependencies on your machine too.

You can now install better networking software.
I prefer [NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager),
since it's the easiest to work with, but do bear in mind it has _a lot_ of
package dependencies.
```zsh
pacman -S networkmanager network-manager-applet
systemctl enable --now NetworkManager
```

The dotfiles automatically launch `nm-applet` so you have it on the system tray.

---
- **Setting up ZSH**

I prefer having `zsh` as the default shell, even for `root`, like the Arch
installation media does.

```sh
pacman -S zsh
chsh -s /bin/zsh
ln -sf /bin/zsh /bin/sh
```

Logout to apply changes.
Running `echo $0` should now return `-zsh`.

---
- **Create your personal user**

For the purposes of this section, set the `$USERNAME` variable or replace its
occurrences with your desired name (lowercase no spaces).

This command will create your user, its `$HOME` directory, add it to the `wheel`
group so it has access to `sudo`, and sets the login shell to `zsh`.
```zsh
useradd -m -G wheel -s /bin/zsh $USERNAME
```

For some reason, even when not using `bash`, `useradd` will create init files 
for it, cluttering your home directory.
Purge them!
```zsh
rm /home/$USERNAME/.bash*
```

Set a password for the user:
```zsh
passwd $USERNAME
```

Give sudo access to the `wheel` group.
```zsh
nvim /etc/sudoers
# Uncomment the line: %wheel ALL=(ALL) ALL
```

You may **now logout** from root and login as your own user.
When you log back in, ZSH will tell you that you don't have any config files and
offer to create one for you. _Ignore it_ (press `q`), as those will be added in
later by the dotfiles.

---
- **Install an AUR helper**

The dotfiles repo depends on some packages not available in the standard Arch
repositories, so you need to install an AUR helper for those.
I recommend [yay](https://github.com/Jguer/yay) since it uses the same syntax as
`pacman`.

?> This step **must** be done as a non-root user with `sudo` privileges.

The process is simple:
- Install `git`, if you haven't already.
- Clone the `yay` repo.
- Build the package
- Remove build files.

```shell script
sudo pacman -S git
cd /tmp
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd
rm -rf /tmp/yay-git
```

---
That's about it.
The dotfiles will take care of the rest.

[_Next Step: Dotfile Setup_](installation/setup.md)
