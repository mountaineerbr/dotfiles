#!/usr/bin/bash

if ((!$#))
then 	exec feh --edit --insecure --scale-down --auto-zoom --geometry 640x480+300+100 "${@}";
elif (($#<2)) && [[ ! -d $1 ]]
then 	exec feh --edit --insecure --scale-down --auto-zoom --geometry 640x480+300+100 --start-at "${@:1:1}" "$(dirname "${@:1:1}")";
else 	exec feh --edit --insecure --scale-down --auto-zoom --geometry 640x480+300+100 --start-at "${@:1:1}" "${@}";
fi
