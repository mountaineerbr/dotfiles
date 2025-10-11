#sourced by ~/.rc, ~/.bashrc, or ~/.zshrc
# vi: ft=bash

#tmux
#file to hold Tmux signal
_TMUXSIG="${TMPD:-/tmp}/tmux.exit.$EUID"

#exit tmux, and terminal emulator
qq() { 	[[ -z $TMUX ]] || echo exit >"$_TMUXSIG"; exit ;}

#start tmux
if [[ -n $ZSH_VERSION && -z $TMUX$VIFMSET && $EUID -gt 0 ]]
then
	# Check if the line contains "attached"
	unset REPLY session;
	while IFS= read -r
	do case "$REPLY" in *[Aa]ttached*) continue;;
		[0-9]:*|[0-9][0-9]:*) session=${REPLY%%:*}; break;;
	  esac;
	done < <(tmux ls)
	# If attached session is found, attach to it
	if [[ -n $session ]]
	then
		command tmux attach  #attach-session -t $session
	# If no detached session found, create a new session
	else
		command tmux
	fi &&
	#is exit signal file present?
	if [[ -e $_TMUXSIG ]]
	then
		#execute a simple command
		set -- "$(<"$_TMUXSIG")"
		command rm "$_TMUXSIG"
		eval "$*"
		set --
	fi
	unset REPLY session;
	#new-session -n $HOST
	#tmux attach \; new-window
#Tmux DBUS (and other envars) on my Arch Linux i7
elif [[ -n $TMUX && -z $DBUS_SESSION_BUS_ADDRESS ]] && pidof -q xfce4-session
then
	while read envar
	do 	export "$envar"
	done < <(xargs --null --max-args=1 < /proc/$(pidof xfce4-session)/environ \
	| grep -e DBUS_SESSION_BUS_ADDRESS -e CDM_SPAWN -e CREDENTIALS_DIRECTORY \
	-e DEBUGINFOD_URLS -e GTK3_MODULES -e GTK_MODULES -e '^HG' -e LC_ADDRESS \
	-e LC_MEASUREMENT -e LC_MONETARY -e LC_TIME -e LESSOPEN -e MAIL \
	-e MOTD_SHOWN -e NVCC_PREPEND_FLAGS -e XDG_RUNTIME_DIR -e XDG_SEAT \
	-e XDG_SESSION_CLASS -e XDG_SESSION_ID -e XDG_SESSION_TYPE -e XDG_VTNR)
	unset envar
	#https://askubuntu.com/questions/772631/how-to-connect-screen-tmux-byobu-to-dbus
	#dont use: export $(dbus-launch)
	#https://bbs.archlinux.org/viewtopic.php?id=289375
fi


#exit tmux and rerun last command
#{
#	if [[ -n $TMUX ]]
#	then 	fc -ln -- -1 >"$_TMUXSIG"
#		exit
#	else 	fc -s
#	fi
#}

