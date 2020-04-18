# Dotfiles Setup
It is finally time to install the dotfiles.

?>**NOTE:** The setup has not yet been fully completed.
The provided script is basic and _will_ be changed in the future.
However, it works for testing purposes.



---
- **Clone the repository**

Choose any location you'd like. To avoid cluttering my home directory, I usually
go for something like `~/docs/repo`.

```zsh
mkdir -p ~/docs/repo
git clone https://github.com/Jadarma/dotfiles.git ~/docs/repo 
cd ~/docs/repo/dotfiles
```

---
- **Run the setup script**

!> **WARNING:** The setup process was intended to be used on a fresh install.
If you are trying to install this over your existing setup, I would recommend
you just do it manually, by following the commands in the script.
Proceed at your own risk.

```zsh
zsh setup.zsh
```
You will be prompted for passwords when installing the dependencies.

---
- **Reboot and log in**

Run `reboot`, then after logging back in, run `startx` and you're in!
