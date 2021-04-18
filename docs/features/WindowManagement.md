# Window Management

This section describes working with windows using the `bspwm` tiling window manager.

## Usage

The BSP from BSPWM stands for "Binary Space Partition".
Imagine your desktop being the root node of a tree, with your windows as leaf nodes, splitting it up into "branches".
It is a manual tiler, meaning you as the user are mostly responsible for moving them about.

It has been chosen for the following reasons:

* **Configured via shell scripts.** Every aspect of `bspwm` is controlled via a command-line tool called `bspc`, meaning
  configurations and actions you can take are just scripts, making them very extensible.
* **Minimalism.** This is only a window manager.
  It does not come with its own hotkey daemon or even a status bar, allowing you to use whatever other tools you want
  without bloating your system with its default replacements.
* **Painless Multi-Monitor.** It is monitor-aware, and it is very easy to work with multiple monitors out of the box.

Look over the documentation for general concepts and usage.
The best way to learn is a hands-on approach.
See the next section for hotkeys and currently available behavior.

## Hotkeys

### General Shortcuts

| Key Combination     | Action                                                           |
|:--------------------|------------------------------------------------------------------|
| ++super+alt+q++     | Quit `bspwm`, the equivalent of logging out.                     |
| ++super+alt+r++     | Restart `bspwm`, the equivalent of running the `bspwmrc` script. |

### Navigation / Focus Cycling

With these key bindings you can shift focus between windows, or switch between workspaces and monitors.

| Key Combination                                       | Action                                                      |
|:------------------------------------------------------|-------------------------------------------------------------|
| ++super++ + { ++1++ - ++9++ }                         | Focus the given workspace.                                  |
| ++super++ + { ++up++, ++down++, ++left++, ++right++ } | Focus the next node in the given direction.                 |
| ++super++ + { _, ++shift++} + ++tab++                 | Focus the next / previous node on the current desktop.      |
| ++super++ + { ++comma++, ++period++ }                 | Focus the previous / next desktop on focused monitor.       |
| ++super+ctrl++ + { ++comma++, ++period++}             | Focus the previous / next monitor.                          |

### Node Creation / Destruction

With these key bindings you can control where to insert new nodes, or remove existing ones.
In _preselect_ mode, a colored placeholder will occupy half the size of the current node, showing where the next node
will be placed if it is created.
The _receptacles_ are empty nodes, and can be used for all sorts of stuff, but they're not really used here apart from
keeping empty space.

| Key Combination                                            | Action                                                 |
|:-----------------------------------------------------------|--------------------------------------------------------|
| ++super+shift+q++                                          | Close the focused node.                                |
| ++super+ctrl++ + { ++up++, ++down++, ++left++, ++right++ } | Preselect the given direction. Do it again to cancel.  |
| ++super+o++                                                | Create a receptacle (an empty node).                   |
| ++super+shift+o++                                          | Close all receptacles on the current desktop.          |
| ++super+ctrl++ + { ++comma++, ++period++ }                 | Focus the previous / next monitor.                     |

### Node Movement / Switching

These key bindings are used to move nodes to other desktops or have them swap places with other nodes on the same
desktop.

| Key Combination                                             | Action                                                                   |
|:------------------------------------------------------------|-------------------------------------------------------|
| ++super+shift++ + { ++up++, ++down++, ++left++, ++right++ } | Swap the focused node with the next one in the given direction (only within same desktop) |
| ++super+ctrl++ + { ++1++ - ++9++ }                          | Move the focused node to the given desktop.           |
| ++super+shift++ + { ++1++ - ++9++ }                         | Move the focused node to the given desktop and focus on that desktop too.|

### Node Tiling / Resizing

These key bindings let you control the way nodes are tiled, their size, and the size of the gaps between them.

The _monocle_ layout is like _fullscreen_, but it keeps the status bar visible.
In monocle mode, only the focused node is visible.
Use the left / right focus navigation from earlier to switch between them.
This is nice for having a "background" desktop, where you keep apps that you don't kneed to view more than one at once
without cluttering it (like keeping Steam, Spotify, etc.).
It is configured such that when there is only one node on a desktop, it automatically switches to monocle mode, so you
don't see any gaps on the margins.

Balancing and equalizing refer to the size of nodes.
Balancing makes all nodes in a given subtree (the focused node being the "root") have the same area.
Equalizing makes the focused node have half the area of the subtree (basically resetting the 50% split).
Try them out; it will make sense immediately.

| Key Combination                         | Action                                                             |
|:----------------------------------------|--------------------------------------------------------------------|
| ++super+m++                             | Toggle monocle mode.                                               |
| ++super+t++                             | Toggle tiling mode (the default behaviour) for the focused node.   |
| ++super+s++                             | Toggle floating mode for the focused node.                         |
| ++super+f++                             | Toggle fullscreen mode for the focused node.                       |
| ++super++ + (++shift++) + ++r++         | Rotate the subtree of the focused desktop / node clockwise.        |
| ++super++ + (++shift++) + ++b++         | Balance the subtree of the focused desktop / node.                 |
| ++super++ + (++shift++) + ++e++         | Equalize the subtree of the focused desktop / node.                |
| ++super+alt++ + { ++up++, ++down++, ++left++, ++right++ } | Resize the node by growing or shrinking it in the given direction. |
| ++super++ + { ++open-bracket++, ++close-bracket++ }       | Resize the gaps between all tiled nodes.         |

## Configuration

The main configuration script can be found in `$HOME/.config/bspwm/bspwmrc`.
This file will be sourced every time you start `bspwm`, in this case handled by the display manager.
In here you can define how it behaves, and configure custom rules to make some windows behave differently depending on
their properties.

Examples include making some applications open on certain desktops by default, set some window classes to be floating,
and so on.
Read the `bspc` man page for more information on this.

Since defining some rules can be very lengthy and ugly, and to keep the main config file easy to read, custom rules are
defined in `$HOME/.local/bin/bspwm/bspwm_external_rules`.

Monitor and desktop configurations are often different from machine to machine, the configs can be overridden by the
host override file in `$HOME/.config/dotfiles/$HOSTNAME/bspwm.sh`, or a default is provided.

The key bindings described above are defined in `sxhkd`.
Some make use of custom scripts, which are found in `$HOME/.local/bin/bspwm`.

## Read More
- GitHub: [baskerville/bspwm](https://github.com/baskerville/bspwm)
- ArchWiki: [bspwm](https://wiki.archlinux.org/index.php/bspwm)
