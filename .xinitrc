xsetroot -cursor_name left_ptr
export GTK_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export _JAVA_AWT_WM_NONREPARENTING=1
#fcitx -d &
#nitrogen --restore &
udiskie --no-notify --use-udisks2 --tray &
#xrandr --output LVDS1 --scale 1.405x1.405
eval $(ssh-agent) 
numlockx &
urxvtd &
# xmobar /home/sean/.xmobar/xmobarrc2 &
dunst -config /home/sean/.config/dunst/dunstrc &
redshift -l -23:-47 &
#compton &
exec dbus-launch /home/sean/.xmonad/xmonad-x86_64-linux

