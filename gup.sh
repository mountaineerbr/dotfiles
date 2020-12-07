#!/bin/zsh
# lazy script to update these files for me
# v0.1  dec/2020  by mountaineerbr


#copy different files to $PWD
cpf()
{
	local f e r

	for f in "${@#$PWD}"
	do
		e="$src/$f"
		
		if [[ -f "$e" ]] &&
			! diff -q "$f" "$e" &>/dev/null
		then
			#set $C for actually copying files
			((C)) || print "copy -- $e\nto   -- $PWD/$f" >&2
			((C)) && cp -vf "$e" "$PWD/$f"
		else
			((C)) || print "skip -- $e" >&2
		fi
	done
	
	((C)) || print ">>>set \$C to non-empty to actually copy files" >&2
}

set -e

setopt extendedglob globstarshort nullglob

#~/ dotfiles
#~/.config
src="$HOME"  cpf  .*(.)  .config/**(.)

#/etc
cd etc
src="/etc"  cpf  *(.)
cp -f /etc/pacman.d/mirrorlist pacman.d/mirrorlist
cd ..


