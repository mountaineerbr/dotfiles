# ~/.kshrc
# mountaineerbr


[[ -e ~/.rc ]] && . ~/.rc


set -o emacs

#set -o multiline

PS1='$? ${HOSTNAME}:${PWD##*/} % '

