#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


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
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape' -t 175
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1
# redshift -l -23:-47 &
# compton &
exec /home/sean/.xmonad/xmonad-x86_64-linux
# exec emacs
#exec dbus-launch qtile
#exec notion
