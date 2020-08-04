# 4. Post Installation {docsify-ignore-all}
---

Now that you have a minimal Arch install, it is time to set up your personal user account and other minor details.
You may want to personalize this step, so for that reason it is not imposed on you.
The following steps are what I use.

## 4.1 Network Configuration

In the installation step we installed our networking stack: 
[`connman`](https://wiki.archlinux.org/index.php/ConnMan)
as our network manager, and [`iwd`](https://wiki.archlinux.org/index.php/Iwd) as our Wi-Fi client (if applicable).
We must now enable the services so that we enable networking at boot time.

```shell script
systemctl enable --now connman iwd
```

If you are on a wired connection, that's it!
For wireless, we need to connect to a network, but we don't need to go through `iwd`, as `connman` can manage it for us.
It, too, has an interactive mode:

```shell script
`connmanctl`
```

This will bring out a new prompt, in which we need to run the following commands:
```shell script
wifi on
scan wifi
services         # Will list all SSIDs.
agent on
connect $SOME_ID # Tab to autocomplete from the output of `services`
quit             # Or [Ctrl+D].
```

> [!TIP]
> I recommend applying the first three [tips and tricks](https://wiki.archlinux.org/index.php/ConnMan#Tips_and_tricks>)
> as described on the wiki, to enforce a single hostname, prefer ethernet to wireless and use an exclusive connection.

You can now ping something to test your connection.

```shell script
ping archlinux.org
```

## 4.2 ZSH

I prefer having `zsh` as the default shell, even for `root`, like the Arch installation media does.

```shell script
pacman -S zsh
chsh -s /bin/zsh
ln -sf /bin/zsh /bin/sh
```

Logout to apply changes.
Running `echo $0` should now return `-zsh`.

## 4.3 User Accounts

We can now manage [users and groups](https://wiki.archlinux.org/index.php/Users_and_groups).
For simplicity, we will only create a single user for our personal use, `user` (you can change this to whatever you
like, but it must be all lowercase).

This command will create your user, its home directory, adds it to the administrator group, and sets the login shell
to `zsh`.
We then set a password for the user.

```shell script
useradd -m -G wheel -s /bin/zsh user
passwd user
```

For some reason, even when not using `bash`, `useradd` will create init files for it, cluttering your home directory.
Purge them!

```shell script
rm /home/user/.bash*
```

The `wheel` group is for non-root administrators, and can be used to give access to `sudo` and `su`, but are not used
by default.
To enable this functionality, edit the `/etc/sudoers` files and uncomment the following line:

```
%wheel ALL=(ALL) ALL
```

If you have `vi` installed, use the `visudo` command instead, otherwise, ignore the readonly file warning
(`:wq!` in `vim` or `nvim`).

You may **now logout** from root and login as your own user.

> [!NOTE]
> When you log back in, ZSH will tell you that you don't have any config files and offer to create one for you.
> **Ignore it** _(press `q`)_, as those will be added in later by the dotfiles.

## 4.4 AUR Helper

The dotfiles repo depends on some packages not available in the standard Arch repositories, so you need to install an
[AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers) for those.
I recommend [yay](https://github.com/Jguer/yay) since it uses the same syntax as `pacman`.

> [!NOTE]
> This step **must** be done as a non-root user with `sudo` privileges.

The process is simple.
We need to install `git` and clone the `yay` repository, build the package then do some cleanup.

```shell script
sudo pacman -S git
git clone https://aur.archlinux.org/yay-git.git /tmp/yay-git
cd /tmp/yay-git
makepkg -si
cd
rm -rf /tmp/yay-git
```
