#!/bin/bash
if [[ $(emacsclient --e '(org-clocking-p)') == 't' ]] ; then
	str=$(cat /tmp/clocking)
	str="<fc=#100a04,#9A6C2C> ${str} <fc=#9a6c2c,#190f0b></fc>" 
	echo "${str}"
else
    echo "<fc=#ffffff,#ff0000> `date +%H:%M:%S` Procrastinando... </fc><fc=#ff0000,#190f0b>"
fi


