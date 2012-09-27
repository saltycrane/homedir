# Note that since qtile configs are just python scripts, you can check for
# syntax and runtime errors by just running this file as is from the command
# line, e.g.:
#
#    python config.py
import os

from libqtile.manager import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

# The screens variable contains information about what bars are drawn where on
# each screen. If you have multiple screens, you'll need to construct multiple
# Screen objects, each with whatever widgets you want.
#
# Below is a screen with a top bar that contains several basic qtile widgets.
screens = [
    Screen(
        bottom=bar.Bar(
            [
                # This is a list of our virtual desktops.
                widget.GroupBox(urgent_alert_method='text'),

                widget.Spacer(width=200),
                # A prompt for spawning processes or switching groups. This will be
                # invisible most of the time.
                widget.Prompt(),
                # widget.Notify(),  # not available (why?)
                widget.CurrentLayout(),
                widget.Volume(),
                widget.Battery(
                    energy_now_file='charge_now',
                    energy_full_file='charge_full',
                    power_now_file='current_now',
                    ),
                widget.Systray(),
                widget.Clock('%Y-%m-%d %a %I:%M %p'),
                widget.WindowName(),
                ],
            20)
        )
    ]

# Super_L (the Windows key) is typically bound to mod4 by default, so we use
# that here.
mod = "mod4"

# The keys variable contains a list of all of the keybindings that qtile will
# look through each time there is a key pressed.
keys = [
    # Admin commands
    Key([mod, "control"], "q",     lazy.shutdown()),
    Key([mod, "control"], "r",     lazy.restart()),
    Key([mod], "Return",           lazy.spawn("urxvt")),
    Key([mod], "F2", lazy.spawn("dmenu_run -fn 'Monospace:size=10' -nb '#000000' -nf '#fefefe'")),
    Key([mod], "F4", lazy.spawn("slock")),
    Key([mod, "shift"], "c",       lazy.window.kill()),

    # Layout commands
    Key([mod], "k",                lazy.layout.down()),
    Key([mod], "j",                lazy.layout.up()),
    Key([mod], "h",                lazy.layout.previous()),
    Key([mod], "l",                lazy.layout.next()),
    Key([mod, "control"], "k",     lazy.layout.shuffle_up()),
    Key([mod, "control"], "j",     lazy.layout.shuffle_down()),
    # move_up() and move_down() are only supported by tree layout
    Key([mod, "shift"], "k",       lazy.layout.move_up()),
    Key([mod, "shift"], "j",       lazy.layout.move_down()),
    Key([mod, "shift"], "h",       lazy.layout.client_to_previous()),
    Key([mod, "shift"], "l",       lazy.layout.client_to_next()),
    Key([mod], "d",                lazy.layout.toggle_split()),
    Key([mod, "shift"], "space",   lazy.window.toggle_floating()),
    Key([mod], "F12",              lazy.window.toggle_fullscreen()),
    Key([mod], "u",                lazy.layout.rotate()),
    Key([mod], "Tab",              lazy.nextlayout()),
    # decrease_ratio() and increase_ratio() are only supported by tile layouts
    Key([mod], "q", lazy.layout.decrease_ratio()),
    Key([mod], "e", lazy.layout.increase_ratio()),

    # Change the volume if your keyboard has special volume keys.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),

    # Also allow changing volume the old fashioned way.
    Key([mod], "equal", lazy.spawn("amixer -c 0 -q set Master 2dB+")),
    Key([mod], "minus", lazy.spawn("amixer -c 0 -q set Master 2dB-")),
]

# This allows you to drag windows around with the mouse if you want.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Next, we specify group names, and use the group name list to generate an appropriate
# set of bindings for group switching.
groups = []
for i in ["1", "2", "3", "4", "5", "6", "7"]:
    groups.append(Group(i))
    keys.append(
        Key([mod], i, lazy.group[i].toscreen())
    )
    keys.append(
        Key([mod, "shift"], i, lazy.window.togroup(i))
    )

# Two basic layouts.
layouts = [
    # layout.Stack(stacks=2, border_width=1),
    # layout.Stack(stacks=3, border_width=1),

    layout.Stack(stacks=[50, 50], border_width=1),
    layout.Stack(stacks=[40, 60], border_width=1),
    # layout.Stack(stacks=[70, 30], border_width=1),
    layout.Max(),
    # layout.Stack(stacks=[33, 33, 33], border_width=1),

    # layout.Tile(),
    # layout.Tile(ratio=0.25),
]
