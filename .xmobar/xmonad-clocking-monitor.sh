#!/bin/bash
if [[ $(emacsclient --e '(org-clocking-p)') == 't' ]] ; then
	str=$(cat /tmp/clocking)
	str="<fc=#dfeded,#8da1a1> ${str} <fc=#8da1a1,#190f0b></fc>" 
	echo "${str}"
else
    echo "<fc=#ffffff,#ff0000> `date +%H:%M:%S` </fc><fc=#ff0000,#190f0b>"
fi


