from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod4"

keys = [
    # Admin commands
    Key([mod, "control"], "q",     lazy.shutdown()),
    Key([mod, "control"], "r",     lazy.restart()),
    Key([mod], "Return",           lazy.spawn("urxvt")),
    Key([mod], "F2", lazy.spawn("dmenu_run -fn 'Monospace:size=14' -nb '#000000' -nf '#fefefe'")),
    Key([mod], "F4", lazy.spawn("slock")),
    # Key([mod], "F4", lazy.spawn("gnome-screensaver-command -l")),
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

# groups = [Group(i) for i in "asdfuiop"]
groups = [
    Group('1-main', layout='s404020'),
    Group('2-email', layout='s6040'),
    Group('3-vm', layout='s8020'),
    Group('4-misc', layout='s8020'),
]
for i, group in enumerate(groups, start=1):
    keys.append(
        Key([mod], str(i), lazy.group[group.name].toscreen())
    )
    keys.append(
        Key([mod, "shift"], str(i), lazy.window.togroup(group.name))
    )

# Border settings for layouts
border = {
    'border_normal': '#808080',
    'border_width': 4,
}

layouts = [
    layout.VWStack(stack_widths=[40, 40, 20], name='s404020', **border),
    layout.VWStack(stack_widths=[60, 40], name='s6040', **border),
    layout.VWStack(stack_widths=[80, 20], name='s8020', **border),
    layout.Max(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=16,
    padding=3,
)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.Spacer(width=100),
                widget.GroupBox(),
                widget.Prompt(),
                widget.Sep(),
                widget.CurrentLayout(),
                widget.Sep(),
                widget.Volume(),
                widget.Sep(),
                widget.Battery(),
                widget.Sep(),
                widget.Systray(),
                widget.Sep(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.Sep(),
                widget.Notify(),

                widget.Spacer(width=20),
                widget.WindowName(),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True
wmname = "qtile"
