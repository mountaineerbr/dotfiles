#
# ~/.profile
# 2026  by mountaineerbr
# config source for bash and zsh
#
# executed by the command interpreter for login shells
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists
# see /usr/share/doc/bash/examples/startup-files


#bash interactive login shells
[[ -n $BASH_VERSION ]] && [[ $- = *i* ]] &&
	[[ -e "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

#personal api keys
[[ -e "$HOME/.apikeys" ]] && . "$HOME/.apikeys"


#set custom $PATH
for dir in  \
	"$GOPATH/bin" \
	"$HOME/.local/bin" \
	"$HOME/bin/more" \
	"$HOME/bin/markets" \
	"$HOME/bin" \
	"." 
do
	if [[ -d $dir ]] && [[ :$PATH: != *:${dir:-x}:* ]]
	then 	PATH=$dir:$PATH
	fi
done
unset dir

#set $CDPATH
CDPATH=".:..:$HOME:$HOME/bin:$CDPATH"
CDPATH="${CDPATH%:}"
#https://linux.101hacks.com/cd-command/cdpath/
#https://bosker.wordpress.com/2012/02/12/bash-scripters-beware-of-the-cdpath/

#golang path
export GOPATH="$HOME/go"

#full-screen text editor
export VISUAL="${VISUAL:-vim}"
#stream editor
export EDITOR="$VISUAL"
#sudoers editor
export SUDO_EDITOR="$VISUAL"

export BROWSER="w3m"
#if [ -n "$DISPLAY" ]
#then export BROWSER=firefox
#else export BROWSER=links
#fi
#https://wiki.archlinux.org/index.php/environment_variables#Examples

#mail
#export MAIL="/var/mail/$USER"
#export EMAIL=nobody@nowhere.away

#pager
export PAGER=less

#less config
#export LESSOPEN="|lesspipe.sh %s"  #just install pkg `lesspipe'
#export LESS=' -R'
#
#LESS='-i -e -M -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

#bat pages
export BAT_STYLE="numbers"

#man pager
#export MANPAGER="vim -M +MANPAGER -u ~/.vimrc_manpager -"
#export MANWIDTH=83
#export MANPAGER='col -b | vim -u ~/.vimmanrc --not-a-term -'  #trilby
#from arch wiki: https://wiki.archlinux.org/title/Color_output_in_console#Using_less
#export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"
#grotty from groff >1.23.0 requires "-c" option to output overstricken output instead of ansi escapes. less relies on the overstrike formatting to apply its color options, so we need man to pass this option when formatting the man pages for customization to be effective.

#timezone config (unix system can automatically set locale time)
#export TZ=America/Sao_Paulo
#export TZ=/etc/localtime  #dont TZ=:/etc/localtime
#https://bbs.archlinux.org/viewtopic.php?id=65318&p=279

#`ls -l` date format
export TIME_STYLE="long-iso"

#set up for a better xfce4 session
export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_SELECT=4  #qt4 is deprecated
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

#make sure user locale is loaded (depends on user settings)
#I don't know of programs that will use ~/.config/locale.conf.
#Most (if not all) Linux/glibc programs use the LANG and LC_* environment 
#variables. So to have a working locale in your environment, you have to know
#how unix environment variables are inherited and from where in your case.
#unset LANG && source /etc/profile.d/locale.sh
#https://arch-general.archlinux.narkive.com/XzmUEBIU/where-s-my-locale-gone

#export LANG=pt_BR.UTF-8
#export LC_NUMERIC=$LANG
#export LC_MONETARY=$LANG
#export LC_PAPER=$LANG
#export LC_NAME=$LANG
#export LC_ADDRESS=$LANG
#export LC_TELEPHONE=$LANG
#export LC_MEASUREMENT=$LANG
#export LC_IDENTIFICATION=$LANG
#export LC_TIME=$LANG
#export PAPERSIZE=a4
##export LANGUAGE=$LANG

#xdg base directory specification
#export XDG_CONFIG_HOME=$HOME/.config
#export XDG_CONFIG_HOME=$HOME/.cache 
#export XDG_DATA_HOME =$HOME/.local/share
#more in ~/.config/user-dirs.dirs
#xdg-user-dir TEMPLATES

#ViFM c file
#MYVIFMRC="$VIFM/vifmrc"
#MYVIFMRC="$HOME/.vifmrc"

#fim, fbi improved file viewer
#export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

#enable 32x32 cursors
#XCURSOR_SIZE=32
#from crystal-style icon-set (Marco Martin, 2004)

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022


#MOZILLA FIREFOX
#Enable OpenGL in `pvkrun' and `primusrun'
#export LD_PRELOAD=/usr/lib/libGL.so
#export ENABLE_PRIMUS_LAYER=1
#{ ENABLE_PRIMUS_LAYER=1 optirun path/to/application ;}
#https://github.com/felixdoerre/primus_vk
#`LD_PROLOAD' causes problems with `seccomp', for eg `file .bashrc'
#Disable `seccomp' in this case, for eg `file -S .bashrc'
#{ LD_PRELOAD=/usr/lib/libGL.so firefox ;}
#Hardened malloc: https://wiki.archlinux.org/index.php/Security
#https://bugs.archlinux.org/task/65250
#https://bbs.archlinux.org/viewtopic.php?id=252257
#`layers.offmainthreadcomposition.enabled' became on by defaults.
#https://www.reddit.com/r/firefox/comments/4j0tzz/what_happened_to/

#This content should be clarified
#`gfx.webrender.all = true' only works on Firefox Nightly
#https://mozillagfx.wordpress.com/2019/01/17/webrender-newsletter-36/
#To enable WebRender on Firefox Stable:
#export MOZ_ACCELERATED=1 	#same as:`layers.acceleration.force-enabled = true'
#export MOZ_WEBRENDER=1 	#same as: `gfx.webrender.all = true'
#https://wiki.archlinux.org/index.php/Talk:Firefox/Tweaks

#Do *not* set if using NVIDIA `primusrun'
#export MOZ_OMTC_ENABLED=1
#export MOZ_USE_OMTC=1
#https://gist.github.com/yuttie/de097d004499adb984bd


#pulseaudio-module-xrdp
#Remember to pass the environment var to pulseaudio to make this module work:
#PULSE_SCRIPT=/etc/xrdp/pulse/default.pa
# ~/.config/pulse/default.pa: .include /etc/xrdp/pulse/default.pa

#check performance running a demo from `mesa-demos'
#demos: glxgears -info, glxspheres64 and glxspheres32
#optirun [demo]
#optirun -b primus [demo]
#primusrun [demo]
#pvkrun  [demo]
#OBS: `optirun' is the only which enables NVIDIA renderer for me

#bcalc.sh extensios file for bc
export BCEXTFILE="$HOME/bin/bcalc_ext.bc"

#config for bitcoin.{blk,tx}.sh
export BITCOINCONF=/media/primary/blockchain/bitcoin.conf

#wf.sh -- norway institute of meteorology
export WFAV="apucarana:-23.5525327:-51.4610764:840
arapongas:-23.4152862:-51.4293961:816
astorga:-23.2350184:-51.6647074:675
belo horizonte:-19.9227318:-43.9450948:852
cascavel:-24.9554996:-53.4560544:781
foz do igua[cç][uú]:-25.5401479:-54.5858139:164
general carneiro:-26.422982:-51.3146691:983
gramado:-29.3924265:-50.912571:850
guaratuba:-25.8806192:-48.5750905:0
ponta grossa:-25.0891685:-50.1601812:975
porto alegre:-30.0324999:-51.2303767:10
sapopema:-23.9105099:-50.5791315:759
tibagi:-24.50944:-50.41361:748
ribeirao preto:-21.180889:-47.845444:546"


#is it linux tty?
if [[ "$TERM" = linux ]]
then
	#set linux tty font
	#terminus-normal-18 or 20 (for 15" displays)
	##setfont ter-u18n -m 8859-2
	##already set console font in /etc/vconsole.conf,
	##see https://wiki.archlinux.org/title/Linux_console#Fonts
	
	#cursors for linux tty
	#normal blinking underline:
	#{ echo -e '\033[?2c';}
	#blinking block:
	#{ echo -e '\033[?6c';}
	#red non-blinking block:
	#{ echo -e '\033[?17;0;64c';}
	#bold white on red
	echo -e "\e[?16;0;74c"
	#is it possible that hardware has got default cursor colour?
	#https://linuxgazette.net/137/anonymous.html
	#VGA-softcursor.txt 
	#http://fxr.watson.org/fxr/source/Documentation/VGA-softcursor.txt?v=linux-2.4.22
	#as per reference, you may find crazy combinations (hardware-specific and unpredictable results)

	#linux tty text and background colours
	#bold  - extra  bright, mode on|off
	#invert fb and bg colours - --inversescreen on|off
	#{ setterm -background black -foreground green --bold on;}
	#https://unix.stackexchange.com/questions/55423/how-to-change-cursor-shape-color-and-blinkrate-of-linux-console
fi


#start x? - simple x init
#mystartxf()
#{
#	local REPLY
#	if [[ "$EUID" -gt 0 ]] && [[ "$XDG_VTNR" -eq 1 ]] && [[ -z "$DISPLAY" ]]
# 	then
#		## Start X Server?
#		printf 'Start X Server? y/N ' ;read
#		case $REPLY in
#			[Yy]* ) echo 'Yes!' ;startx ;;
#			[Nn]* ) echo 'Answer is no' ;;
#			* ) 	echo 'No!' >&2 ;;
#		esac
#	fi
#}
#mystartxf


#
#       ,o888888o.           .8.            d888888o. 8888888 8888888888 
#      8888     `88.        .888.         .`8888:' `88.     8 8888       
#   ,8 8888       `8.      :88888.        8.`8888.   Y8     8 8888       
#   88 8888               . `88888.       `8.`8888.         8 8888       
#   88 8888              .8. `88888.       `8.`8888.        8 8888       
#   88 8888             .8`8. `88888.       `8.`8888.       8 8888       
#   88 8888            .8' `8. `88888.       `8.`8888.      8 8888       
#   `8 8888       .8' .8'   `8. `88888.  8b   `8.`8888.     8 8888       
#      8888     ,88' .888888888. `88888. `8b.  ;8.`8888     8 8888       
#       `8888888P'  .8'       `8. `88888. `Y8888P ,88P'     8 8888       
#                                                                      
#           .8. `8.`888b                 ,8' .8.   `8.`8888.      ,8' 
#          .888. `8.`888b               ,8' .888.   `8.`8888.    ,8'  
#         :88888. `8.`888b             ,8' :88888.   `8.`8888.  ,8'   
#        . `88888. `8.`888b     .b    ,8' . `88888.   `8.`8888.,8'    
#       .8. `88888. `8.`888b    88b  ,8' .8. `88888.   `8.`88888'     
#      .8`8. `88888. `8.`888b .`888b,8' .8`8. `88888.   `8. 8888      
#     .8' `8. `88888. `8.`888b8.`8888' .8' `8. `88888.   `8 8888      
#    .8'   `8. `88888. `8.`888`8.`88' .8'   `8. `88888.   8 8888      
#   .888888888. `88888. `8.`8' `8,`' .888888888. `88888.  8 8888      
#  .8'       `8. `88888. `8.`   `8' .8'       `8. `88888. 8 8888
#
# art: figlet

