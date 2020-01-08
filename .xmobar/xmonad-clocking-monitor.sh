#!/bin/bash
if [[ $(emacsclient --e '(org-clocking-p)') == 't' ]] ; then
	str=$(cat /tmp/clocking)
	str="<fc=#f9f5d7,#af3a03> ${str}" 
	echo "${str}"
else
    echo "<fc=#ffffff,#ff0000> `date +%H:%M:%S` </fc><fc=#ff0000,#fbf1c7>"
fi


