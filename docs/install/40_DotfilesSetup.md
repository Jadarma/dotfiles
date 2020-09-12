# 4. Dotfiles Setup {docsify-ignore-all}
---

> [!WARNING]
> The setup script is a working prototype, but has not yet been fully completed.
> It might be changed in the future.

Now that you have a minimal Arch install, it is finally time to install the dotfiles.

There are only two prerequisites to running it: `zsh` and `git`, both of which we already installed during
bootstrapping.
To double check you can use `pacman -Q zsh git`.

## 4.1 Clone the Repository

Choose any location you'd like.
I usually go for `/tmp`.

Just clone the repository somewhere then `cd` into it.
```shell script
mkdir /tmp/dotfiles
git clone https://github.com/Jadarma/dotfiles.git /tmp/dotfiles
cd /tmp/dotfiles
```

## 4.2 Setup Script

The script is automated and reads its configuration from the `setup/conf/dotinstall.conf` file.
Here, you can edit various options to customise your installation to your liking.
You definitely want to edit this file to set your own values, as it comes preconfigured with my own settings.

Each config variable is documented.
Read more details there. 

```shell script
nvim setup/conf/dotinstall.conf
```

Once you are satisfied with your settings, just run the main script.
You will be prompted for a disclaimer, and a password for the new user, if necessary.

```shell script
zsh setup/dotinstall.zsh
```

> [!DANGER]
> The setup process was intended to be used on a fresh install.
> If you are trying to install this over your existing setup, I would recommend
> you just do it manually, by following the commands in the script.
> Proceed at your own risk.

## 4.3 Installation Complete

You may now reboot and be greeted by the login screen.\
**That's it! Enjoy your new setup!**
