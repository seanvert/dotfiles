xsetroot -cursor_name left_ptr
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export _JAVA_AWT_WM_NONREPARENTING=1
#fcitx -d &
#nitrogen --restore &
udiskie --no-notify --use-udisks2 --tray &
eval $(ssh-agent) 
numlockx &
urxvtd &
stalonetray &
xrdb ~/.Xresources
dunst -config /home/sean/.config/dunst/dunstrc &
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape' -t 175
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1
# redshift -l -23:-47 &
# compton &
exec dbus-launch /home/sean/.xmonad/xmonad-x86_64-linux
# exec emacs
#exec dbus-launch qtile
#exec notion
