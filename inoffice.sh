xrandr --output DP-1 --off
xrandr --output DP-1 --auto
xrandr --output eDP-1 --mode 1920x1080 --same-as DP-1
gsettings set org.gnome.desktop.interface text-scaling-factor 1
/usr/lib/gnome-settings-daemon/gsd-xsettings &
