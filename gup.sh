#!/bin/zsh
# lazy script to update these files for me
# v0.1  dec/2020  by mountaineerbr


set -e

#source diffcp()
. ~/.rc

setopt extendedglob globstarshort nullglob

#~/ dotfiles
#~/.config
src="$HOME"  diffcp  .*(.)  .config/**(.)

#/etc
cd etc
src="/etc"  diffcp  *(.)
cp -f /etc/pacman.d/mirrorlist pacman.d/mirrorlist
cd ..

