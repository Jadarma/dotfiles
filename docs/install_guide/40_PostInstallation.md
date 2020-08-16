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
