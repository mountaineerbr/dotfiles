#!/bin/bash
# v0.6.4  sep/2025  by mountaineerbr
#this script just starts the conky instances once.
#see ~/.config/systemd/user/conky-{session.service,restart.timer}
#`xscreensaver' may interfere with restarting conky properly

#!#export DISPLAY=":0.0"  #":0"

CONFS=(
	"$HOME/.config/conky/confs/btc.conf"
	"$HOME/.config/conky/confs/calendar.conf"
	"$HOME/.config/conky/confs/todo.conf"
	"$HOME/.config/conky/confs/aurora_allinone.conf"
	"$HOME/.config/conky/confs/aurora_ds_sensors.conf"
	"$HOME/.config/conky/confs/rss_long1.conf"
	"$HOME/.config/conky/confs/rss_short1.conf"
	"$HOME/.config/conky/confs/rss_short2.conf"
	"$HOME/.config/conky/confs/calendar-moon.conf"
)

#PID file
#pidfile="/tmp/${EUID}.${0##*/}.pid"
#echo $$ >"$pidfile"

killall conky 2>/dev/null
sleep 2
killall -0 conky 2>/dev/null && killall -9 conky

for c in "${CONFS[@]}"
do
	sleep 1
	conky --daemonize --pause=2 -c "$c" || exit
	#!#conky --daemonize --pause=2 -X "${DISPLAY}" -c "$c" || exit
done
#-d daemonises conky
#-c configuration file
#-p time to pause before actually starting conky
#--display X11 display to use
