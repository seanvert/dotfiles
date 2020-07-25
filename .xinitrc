stalonetray &
xsetroot -cursor_name left_ptr
export GTK_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export _JAVA_AWT_WM_NONREPARENTING=1
#fcitx -d &
#powerline-daemon -q &
#nitrogen --restore &
udiskie --no-notify --use-udisks2 --tray &
#feh --bg-scale /home/sean/Images/wallpaper/wallpaper\ da\ sua\ vida.jpg
#xrandr --output LVDS1 --scale 1.405x1.405
eval $(ssh-agent) 
numlockx &
urxvtd &
xmobar /home/sean/.xmobar/xmobarrc2 &
dunst -config /home/sean/.config/dunst/dunstrc &
redshift -l -23:-47 &
#compton &
exec dbus-launch /home/sean/.xmonad/xmonad-x86_64-linux

