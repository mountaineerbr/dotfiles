# ~/.kshrc
# mountaineerbr


[[ -e ~/.rc ]] && . ~/.rc

set -o emacs

set -o multiline

PS1='$? ${HOSTNAME}:${PWD##*/} % '


##Set in /etc/environment or /etc/profile
##ENV is .kshrc only when the shell is invoked in an interactive context,
##and empty for a script, thanks to the array indexing based on the value of $-.
#ENVFILE=$HOME/.kshrc
#export ENVFILE
#ENV='${ENVFILE[(_=1)+(_$-=0)-_${-%%*i*}]}'
#export ENV
##https://groups.google.com/g/comp.unix.shell/c/m7mY8fp69Fc

