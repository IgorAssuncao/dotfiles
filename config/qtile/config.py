# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, MODify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, hook, layout, widget
from libqtile.command import lazy
from libqtile.config import Click, Drag, Group, Key, Screen


def get_profile_var(variable):
    profile_path = '~/system-config/.config/user-settings/.profile'
    command = f"grep {variable} {profile_path} | cut -d '=' -f2"
    var = subprocess.run(
        ["sh", "-c", command],
            stdout=subprocess.PIPE
        ).stdout.decode("utf-8").replace('\n', '').split('/')[-1]
    return var

GROUPS = "1234qwer"
MOD = "mod4"
SPACER = 16
TERMINAL = get_profile_var("TERM")
EDITOR = get_profile_var("EDITOR")
BROWSER = get_profile_var("BROWSER")
FILE_MANAGER_TERM = "ranger"
FILE_MANAGER_GUI = "pcmanfm"

@hook.subscribe.startup
def autostart():
    scriptLocation = '~/system-config/.config/qtile/autostart.sh'
    script = os.path.expanduser(scriptLocation)
    subprocess.call([script])

keys = [
    # Switch between windows in current stack pane
    Key([MOD], "j", lazy.layout.down()),
    Key([MOD], "k", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([MOD, "control"], "j", lazy.layout.shuffle_down()),
    Key([MOD, "control"], "k", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([MOD], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([MOD, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([MOD, "shift"], "Return", lazy.layout.toggle_split()),

    # Spawn terminal
    Key([MOD], "Return", lazy.spawn(TERMINAL)),

    # Toggle between different layouts as defined below
    Key([MOD], "Tab", lazy.next_layout()),
    Key([MOD], "w", lazy.window.kill()),

    Key([MOD, "control"], "r", lazy.restart()),
    Key([MOD, "control"], "q", lazy.shutdown()),
    Key([MOD], "r", lazy.spawncmd()),

    # Spawn bmenu
    # Bmenu allows to control multiple settings on the pc
    # Like Package manager UI, System Information, File Manager
    Key([MOD, "control"], "b", lazy.spawn(f"{TERMINAL} -e bmenu")),

    # Spawn system-menu
    # system-menu allows to control Appearance, Network, Sound
    Key([MOD, "control", "shift"], "b", lazy.spawn(f"{TERMINAL} -e system-menu")),

    # Spawn i3-dmenu-desktop and dmenu_run
    Key([MOD], "d", lazy.spawn("i3-dmenu-desktop")),
    Key([MOD, "shift"], "d", lazy.spawn("dmenu_run")),

    # Spawn morce_menu
    Key([MOD], "z", lazy.spawn("morc_menu")),

    # Spawn browser
    Key([MOD], "b", lazy.spawn(BROWSER)),

    # Spawn Ranger (Terminal File Manager)
    Key([MOD], "F2", lazy.spawn(f"{TERMINAL} -e {FILE_MANAGER_TERM}")),

    # Spawn pcmanfm (GUI File Manager)
    Key([MOD], "F3", lazy.spawn(FILE_MANAGER_GUI)),

    # Spawn alsamixer
    Key([MOD, "control"], "m", lazy.spawn(f"{TERMINAL} -e alsamixer")),

    # Spawn pavucontrol
    Key([MOD, "control", "shift"], "m", lazy.spawn("pavucontrol")),

    # Spawn blurlock (Lock screen)
    Key([MOD], "9", lazy.spawn("blurlock"))
]

groups = [Group(i) for i in GROUPS]

for i in groups:
    keys.extend([
        # MOD + letter of group = switch to group
        Key([MOD], i.name, lazy.group[i.name].toscreen()),

        # # MOD + control + letter of group = send window to group
        # Key([MOD, "control"], i.name, lazy.window.togroup(i.name)),

        # MOD + shift + letter of group = switch to & move focused window to group
        Key([MOD, "shift"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
    ])

# Layout theme that will be applied to all layouts specified below
LAYOUT_THEME = {
    "margin": 10,
    "border_width": 1,
    "border_focus": "00ffff",
    "border_normal": "969896",
}

layouts = [
    layout.MonadTall(**LAYOUT_THEME),
    layout.Stack(num_stacks = 2)
]

widget_defaults = {
    "font": "source code pro semibold",
    "fontsize": 9,
    "padding": 3
}
extension_defaults = widget_defaults.copy()

def create_widgets_list():
    widgets = [
        widget.GroupBox(),
        widget.Prompt(),
        widget.Spacer(SPACER),
        widget.WindowName(),
        widget.Spacer(SPACER),
        widget.Systray(),
        widget.Spacer(SPACER),
        widget.CPU(),
        widget.Spacer(SPACER),
        widget.Memory(),
        widget.Spacer(SPACER),
        widget.Volume(),
        widget.Spacer(SPACER),
        widget.Clock(format='%Y-%m-%d %a %I:%M %p')
    ]
    return widgets

def setup_screens():
    screens = [
        Screen(top=bar.Bar(widgets=create_widgets_list()), size=20),
        Screen(top=bar.Bar(widgets=create_widgets_list()), size=20)
    ]
    return screens

screens = setup_screens()

# Drag floating layouts.
mouse = [
    Drag([MOD], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([MOD], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
