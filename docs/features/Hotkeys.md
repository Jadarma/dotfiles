# Hotkeys

All _"system-wide"_ keyboard shortcuts are bound using the Simple X Hotkey Daemon, or `sxhkd` for short.

## Usage

The daemon must run in order to register events.
It is usually ran on user login, in this case via `.xprofile`:

```shell
sxhkd &
```

### Key Bindings

The following keybindings are available: 

| Key Combination | Action                         |
|:---------------:|--------------------------------|
| ++super+esc++   | Reload the configuration file. |

!!! note
    Only sxhkd related bindings are shown here.
    Each feature should document its own added hotkeys.
    To view all bounded hotkeys, you can just print the configuration file.

## Configuration
The configuration file can be found at `.config/sxhkd/sxhkdrc`.

In short, the syntax is as follows: a key combination on one line followed by an indented line that is the command which
will run if that key combination is pressed.
The commands are run in a shell, so environment variables can be used as well.
Curly braces can be used to bind multiple similar combinations that differ by one stroke.
An underscore can be used to mean no key.
You can also bind the script on press or release events.

Example:
```text
super + {_, alt} + h
    notify-send "{🙂 Hello,🙃 Goodbye\, Cruel} World!"
```

In this example, a notification will appear, having a positive or negative message depending on whether the `alt`
modifier was pressed.

## Read More
- GitHub: [baskerville/sxhkd](https://github.com/baskerville/sxhkd)
- ArchWiki: [sxhkd](https://wiki.archlinux.org/index.php/Sxhkd)
