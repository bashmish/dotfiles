#!/usr/bin/env python3
import subprocess
import sys

# install
# https://askubuntu.com/questions/728536/how-can-i-determine-if-a-process-has-a-window-and-subsequently-show-hide-or-cl

# based on https://askubuntu.com/questions/597395/how-to-set-custom-keyboard-shortcuts-from-terminal
# and https://www.semicomplete.com/projects/xdotool/

def change_hotkey(name, hotkey):
    subprocess.call([
        '/bin/bash',
        '-c',
        f'gsettings set org.gnome.desktop.wm.keybindings {name} "[\'{hotkey}\']"'
    ])

def reset_custom_hotkeys():
    subprocess.call([
        '/bin/bash',
        '-c',
        'gsettings reset org.gnome.settings-daemon.plugins.media-keys custom-keybindings'
    ])

def add_custom_hotkey(name, command, hotkey):
    # defining keys & strings to be used
    key = "org.gnome.settings-daemon.plugins.media-keys custom-keybindings"
    subkey1 = key.replace(" ", ".")[:-1]+":"
    item_s = "/"+key.replace(" ", "/").replace(".", "/")+"/"
    firstname = "custom"
    # get the current list of custom shortcuts
    get = lambda cmd: subprocess.check_output(["/bin/bash", "-c", cmd]).decode("utf-8").replace("@as ", "")
    current = eval(get("gsettings get "+key))
    # make sure the additional keybinding mention is no duplicate
    n = 1
    while True:
        new = item_s+firstname+str(n)+"/"
        if new in current:
            n = n+1
        else:
            break
    # add the new keybinding to the list
    current.append(new)
    # create the shortcut, set the name, command and shortcut key
    cmd0 = 'gsettings set '+key+' "'+str(current)+'"'
    cmd1 = 'gsettings set '+subkey1+new+" name '"+name+"'"
    cmd2 = 'gsettings set '+subkey1+new+" command '"+command+"'"
    cmd3 = 'gsettings set '+subkey1+new+" binding '"+hotkey+"'"
    for cmd in [cmd0, cmd1, cmd2, cmd3]:
        subprocess.call(["/bin/bash", "-c", cmd])

change_hotkey('close', '<Control>q')
change_hotkey('switch-applications', '<Control>Tab')
change_hotkey('switch-group', '<Control>grave')
change_hotkey('switch-input-source', '<Control>space')

reset_custom_hotkeys()

add_custom_hotkey(
    'Terminal',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Gnome-terminal | tail -1)"',
    '<Alt>Z'
)

add_custom_hotkey(
    'Nautilus',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Nautilus | tail -1)"',
    '<Alt>F'
)

add_custom_hotkey(
    'SmartGit',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class git-cola | tail -1)"',
    '<Alt>G'
)

add_custom_hotkey(
    'Chromium',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Chromium-browser | tail -1)"',
    '<Alt>C'
)

add_custom_hotkey(
    'Chrome',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Google-chrome | tail -1)"',
    '<Shift><Alt>C'
)

add_custom_hotkey(
    'Firefox',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Firefox | tail -1)"',
    '<Shift><Alt>F'
)

add_custom_hotkey(
    'Visual Studio Code',
    'bash -c "xdotool windowactivate $(xdotool search --onlyvisible --class Code | tail -1)"',
    '<Alt>V'
)