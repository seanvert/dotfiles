#nm-applet &
#volumeicon &
stalonetray &
xsetroot -cursor_name left_ptr
export GTK_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
#xflux -l 23.9 -g 47.5
fcitx -d &
#compton &
#emacs --daemon &
#powerline-daemon -q &
#/home/sean/test.sh &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
nitrogen --restore &
#xfce4-panel --disable-wm-check &
udiskie --no-notify --use-udisks2 &
#feh --bg-scale /home/sean/Images/wallpaper/wallpaper\ da\ sua\ vida.jpg
numlockx &
_todo_pipe=/tmp/.todo-pipe
[[ -S $_todo_pipe ]] || mkfifo $_todo_pipe
urxvtd &
#compton &
#dropbox &
exec xmonad
#urxvtc &
#exec xfce
#exec qtile

