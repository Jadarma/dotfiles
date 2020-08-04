# 5. Dotfiles Setup {docsify-ignore-all}
---

It is finally time to install the dotfiles.

> [!WARNING]
> The setup has not yet been fully completed.
> The provided script is basic and _will_ be changed in the future.
> However, it works for testing purposes.

## 5.1 Clone the Repository

Choose any location you'd like. To avoid cluttering my home directory, I usually
go for something like `~/docs/repo`.

```shell script
mkdir -p ~/docs/repo/dotfiles
git clone https://github.com/Jadarma/dotfiles.git ~/docs/repo/dotfiles
```

## 5.2 Setup Script

> [!DANGER]
> ***This script doesn't work, it's never been tested.***
>
> The setup process was intended to be used on a fresh install.
> If you are trying to install this over your existing setup, I would recommend
> you just do it manually, by following the commands in the script.
> Proceed at your own risk.

```shell script
cd ~/docs/repo/dotfiles
zsh setup.zsh
```

You will be prompted for passwords when installing the dependencies.

## 5.3 Installation Complete

Run `reboot`, you will be greeted by the login screen.

That's it! Enjoy your new setup!
