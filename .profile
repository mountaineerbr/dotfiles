#
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#make sure user locale is loaded (depends on user settings)
#I don't know of programs that will use ~/.config/locale.conf.
#Most (if not all) Linux/glibc programs use the LANG and LC_* environment 
#variables. So to have a working locale in your environment, you have to know
#how unix environment variables are inherited and from where in your case.
#https://arch-general.archlinux.narkive.com/XzmUEBIU/where-s-my-locale-gone
#unset LANG && source /etc/profile.d/locale.sh

#sourced by my ~/.zhenv, too

#if running bash
if [[ -n "$BASH_VERSION" ]]
then
	#source from .bashrc if it exists
	[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
fi

#set custom $PATH
for d in  \
	"/opt" \
	"$HOME/.local/bin" \
	"$HOME/bin/more" \
	"$HOME/bin" \
	.
	#"$HOME/bin/markets" \
do
	if [[ -d "$d" ]] &&
		[[ :"$PATH": != *:"${d:-x}":* ]]
	then
		PATH="$d:$PATH"
	fi
done
unset d

#set $CDPATH
CDPATH=".:..:$HOME:$HOME/bin:$CDPATH"
CDPATH="${CDPATH%:}"
#ex: % CDPATH=/etc
#ex: % cd mail
#pwd: /etc/mail
#https://linux.101hacks.com/cd-command/cdpath/
#a . is needed to cd into $PWD dir before any other in $CDPATH
#https://bosker.wordpress.com/2012/02/12/bash-scripters-beware-of-the-cdpath/

#go path
export GOPATH="$HOME/go"

#full-screen text editor
export VISUAL=vim
#stream editor
export EDITOR="$VISUAL"
#sudoers editor
export SUDO_EDITOR="$VISUAL"

#man pager
#export MANPAGER="vim -M +MANPAGER -u ~/.vimrc_manpager -"
#export MANWIDTH=83

#pager
#export PAGER=less

#ViFM c file
#MYVIFMRC="$VIFM/vifmrc"
#MYVIFMRC="$HOME/.vifmrc"

#fim, fbi improved file viewer
#export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_SELECT=4
export QT_AUTO_SCREEN_SCALE_FACTOR=0
#export QT_SCALE_FACTOR=1  #for hi dpi
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
#https://github.com/manjaro/manjaro-xfce-settings/blob/master/skel/.profile

#gtk 3
#export NO_AT_BRIDGE=1
#keep gtk scrollbars from autohidding:
export GTK_OVERLAY_SCROLLING=0
#https://github.com/AladW/dotfiles/blob/master/xinit/.xinitrc
#https://github.com/linuxmint/Cinnamon/issues/5306

#xdg base directory specification
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CACHE_HOME="$HOME/.cache"

#enable 32x32 cursors
#XCURSOR_SIZE=32
#from crystal-style icon-set (Marco Martin, 2004)

#set default repo for ala.sh script
#default repo?
#user set environment variable $DEFALAREPO ?
#export DEFALAREPO=month

#set temporary directory for gs.sh
export GSTMPDIR="$HOME/www"

#$BROWSER contains the path to the web browser
export BROWSER=w3m
#if [ -n "$DISPLAY" ]; then
#    export BROWSER=firefox
#else 
#    export BROWSER=links
#fi
#https://wiki.archlinux.org/index.php/environment_variables#Examples

#firefox - use hardware acceleration
#do not set if using nvidia primusrun
#export MOZ_USE_OMTC=1
#https://gist.github.com/yuttie/de097d004499adb984bd
#arch wiki firefox tweaks

#enable OpenGL in pvkrun and primusrun
#activates layers.acceleration.force-enabled in firefox
#export LD_PRELOAD=/usr/lib/libGL.so
#export ENABLE_PRIMUS_LAYER=1
#ENABLE_PRIMUS_LAYER=1 optirun path/to/application
#https://github.com/felixdoerre/primus_vk
#LD_PROLOAD causes problems with seccomp, for eg 'file .bashrc'
#disable seccomp in this case, for eg 'file -S .bashrc'
#may use in a case-by-case '$ LD_PRELOAD=/usr/lib/libGL.so firefox'
#see: hardened malloc https://wiki.archlinux.org/index.php/Security
#https://bugs.archlinux.org/task/65250
#https://bbs.archlinux.org/viewtopic.php?id=252257

#cursors for linux tty
#normal blinking underline:
#{ echo -e '\033[?2c';}
#blinking block:
#{ echo -e '\033[?6c';}
#red non-blinking block:
#{ echo -e '\033[?17;0;64c';}
#bold white on red
echo -e "\e[?16;0;74c"
#is it really possible that the hardware default cursor colour (of some at least) is red?
#https://linuxgazette.net/137/anonymous.html
#VGA-softcursor.txt 
#http://fxr.watson.org/fxr/source/Documentation/VGA-softcursor.txt?v=linux-2.4.22
#as per reference, you may find crazy combinations (hardware-specific and unpredictable results)

#linux tty text and background colours
#bold  - extra  bright, mode on|off
#invert fb and bg colours - --inversescreen on|off
#{ setterm -background black -foreground green --bold on;}
#https://unix.stackexchange.com/questions/55423/how-to-change-cursor-shape-color-and-blinkrate-of-linux-console

#start x? - simple display manager
#mystartxf()
#{
#	local REPLY
#
#	# If other than ROOT
#	if (( EUID > 0 ))
# 	then
#		## Start X Server?
#		printf 'Start X Server? y/N '
#
# 		read
#		case $REPLY in
#			[Yy]* )
# 				echo 'Yes!'
#				unset REPLY
# 				startx
# 				;;
#			[Nn]* )
# 				echo 'Answer is no'
# 				;;
#			* )
# 				echo 'No!'
# 				;;
#		esac
#	fi
#}
#mystartxf

