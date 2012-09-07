xmodmap ~/.Xmodmap
sleep 2
gnome-settings-daemon&
gnome-power-manager&
gnome-screensaver&
nm-applet --sm-disable&
# gnome-panel&
urxvt &
# exec wmii
exec qtile
