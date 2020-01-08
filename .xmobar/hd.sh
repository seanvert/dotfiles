root=$(df /dev/sda7 | egrep -o [0-9][0-9]%)
ubuntu=$(df /dev/sda6 | egrep -o [0-9][0-9]%)
windows=$(df /dev/sda5 | egrep -o [0-9][0-9]%)
echo "$root $ubuntu $windows"
