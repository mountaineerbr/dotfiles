#
# ~/.zshrc
# 2021  by mountaineerbr
#               __  ___
# _______ ____ / /_/ _ |_    _____ ___ __
#/ __/ _ `(_-</ __/ __ | |/|/ / _ `/ // /
#\__/\_,_/___/\__/_/ |_|__,__/\_,_/\_, /
#                                 /___/

#Global Order: zshenv, zprofile, zshrc, zlogin

#source important files
[[ -e ~/.rc ]] && . ~/.rc

#GRML's zshrc
grmlzsh() wget -qO- https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
#http://deb.grml.org/pool/main/g/grml-etc-core/  -> '*/etc/zsh/zshrc'
#doc: grml-etc-core*/doc/grmlzshrc.t2t
#https://grml.org/zsh/
#https://zsh.sourceforge.io/releases.html
##https://grml.org/zsh-pony/

#see also grml's /etc/skel/.zshrc
## Settings for umask
#if (( EUID == 0 )); then
#    umask 002
#else
#    umask 022
#fi

#report time of script execution time
#export REPORTTIME=-1  #do not report
export REPORTTIME=60
#it measures cpu time, not wall clock. commands explicitly marked with
#the time keyword still cause the summary to be printed in this case.

#don’t write over existing files with >
#setopt NOCLOBBER  #use >! instead

#set default pager for '% <file'
export READNULLCMD=less  #defaults=more
#export NULLCMD=cat  #defaults=cat

#visual beep
setopt BEEP

#globbing
setopt G_L___OB_ST_A_R__SH____ORT
#**/*c  -> **c
##add as many underscores as you want in zshell opts

# don't throw errors when file globs don't match anything and delete the pattern from the argument list 
#setopt NULL_GLOB
# only throw errors when no globs match anything
setopt CSH_NULL_GLOB

#With NO_NOMATCH set, any patterns which don't match are left alone
setopt NO_NOMATCH
#If a pattern for filename generation has no matches, leave it unchanged
#do not print an error
#setopt NOMATCH
#or use '$ noglob cmd' to ensure that no glob expansion
#will be performed in any case.

#do not require a leading `.' in a filename to be matched explicitly.
#setopt GLOB_DOTS
#or use '**string(D)'

#avoids reflexively the rm prompt when `rm  *'  or  `rm  path/*'
#wait ten seconds and ignore anything typed in that time
setopt RM_STAR_WAIT
#setopt RM_STAR_SILENT

#prompting
setopt PROMPT_SUBST
#setopt PROMPT_BANG
#setopt PROMPT_PERCENT

# power completion / abbreviation expansion / buffer expansion
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt COMPLETE_ALIASES
#Enable autocompletion of privileged environments in privileged commands:
#zstyle ':completion::complete:*' gain-privileges 1
#Warning: This will let Zsh completion scripts run commands with sudo privileges. You should not enable this if you use untrusted autocompletion scripts.

# * shouldn't match dotfiles. ever.
setopt NOGLOBDOTS

#When current word has glob pattern, generate matches as for completion
#and cycle through them like MENU_COMPLETE
#setopt GLOB_COMPLETE

#setopt NUMERIC_GLOB_SORT


# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt AUTO_CD

# display PID when suspending processes as well
setopt LONGLISTJOBS

# report the status of backgrounds jobs immediately
#setopt NOTIFY

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt HASH_LIST_ALL

#On an ambiguous completion, cycle matches in place
setopt MENU_COMPLETE 
#setopt AUTO_MENU  #overriden by MENU_COMPLETE
setopt AUTO_LIST # Auto list ambiguous choices.

setopt LIST_PACKED
setopt LONG_LIST_JOBS

# compete not just at the end
setopt COMPLETEINWORD
#setopt ALWAYS_TO_END

#do not save `history' command
setopt HIST_NO_STORE
#setopt APPEND_HISTORY  #INC_APPEND_HISTORY conflicts with SHARE_HISTIRY
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

#remove command lines from the history list when the first character on the line is a space
setopt NO_HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_FUNCTIONS 
setopt HIST_FIND_NO_DUPS #!#important
#setopt HIST_VERIFY

# import new commands from the history file also in other zsh-session
setopt SHARE_HISTORY

# save each command's beginning timestamp and the duration to the history file
setopt EXTENDED_HISTORY

# Don't send SIGHUP to background processes when the shell exits.
#setopt NOHUP

# avoid "beep"ing
setopt NOBEEP


# make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS

# don't push the same dir twice.
setopt PUSHD_IGNORE_DUPS

# use zsh style word splitting
#setopt NOSHWORDSPLIT

# don't error out when unset parameters are used
#setopt UNSET

#setopt MULTIOS


## some popular options ##

## add `|' to output redirections in the history
#setopt histallowclobber

## try to avoid the 'zsh: no matches found...'
#setopt nonomatch

## warning if file exists ('cat /dev/null > ~/.zshrc')
#setopt NO_clobber

## don't warn me about bg processes when exiting
#setopt nocheckjobs

## alert me if something failed
#setopt printexitvalue

## with spelling correction, assume dvorak kb
#setopt dvorak


## miscellaneous code ##

## Use a default width of 80 for manpages for more convenient reading
#export MANWIDTH=${MANWIDTH:-80}

## Set a search path for the cd builtin
#cdpath=(.. ~)

## ctrl-s will no longer freeze the terminal.
#stty erase "^?"

#history
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
#do not add to history, however it stays in the interactive history
HISTORY_IGNORE='(q|qq|exit|bye)'
#HISTORY_IGNORE="(ls|cd|pwd|exit|cd)"
HISTSIZE=1000000
SAVEHIST=100000

# dirstack handling
DIRSTACKSIZE=20
DIRSTACKFILE="${ZDOTDIR:-${HOME}}/.zdirs"


#zle
#set emacs emulation before setting custom keymaps
bindkey -e

#set keymaps
#zmodload -i zsh/terminfo
typeset -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n $key[Home]      ]] && {
	bindkey -M emacs - $key[Home]    beginning-of-line
	bindkey -M viins - $key[Home]    vi-beginning-of-line
	bindkey -M vicmd - $key[Home]    vi-beginning-of-line
}
[[ -n $key[End]       ]] && {
	bindkey -M emacs - $key[End]     end-of-line
	bindkey -M viins - $key[End]     vi-end-of-line
	bindkey -M vicmd - $key[End]     vi-end-of-line
}
[[ -n $key[Insert]    ]] && {
	bindkey -M emacs - $key[Insert]  overwrite-mode
	bindkey -M viins - $key[Insert]  overwrite-mode
	bindkey -M vicmd - $key[Insert]  vi-insert
}
[[ -n $key[Delete]    ]] && {
	bindkey -M emacs - $key[Delete]  delete-char
	bindkey -M viins - $key[Delete]  vi-delete-char
	bindkey -M vicmd - $key[Delete]  vi-delete-char
}
[[ -n $key[Left]      ]] && {
	bindkey -M emacs - $key[Left]    backward-char
	bindkey -M viins - $key[Left]    vi-backward-char
	bindkey -M vicmd - $key[Left]    vi-backward-char
}
[[ -n $key[Right]     ]] && {
	bindkey -M emacs - $key[Right]   forward-char
	bindkey -M viins - $key[Right]   vi-forward-char
	bindkey -M vicmd - $key[Right]   vi-forward-char
}
#[[ -n $key[Up]        ]] && bindkey - $key[Up]         up-line-or-history
#[[ -n $key[Down]      ]] && bindkey - $key[Down]       down-line-or-history
[[ -n $key[PageUp]    ]] && bindkey - $key[PageUp]     up-line-or-history
[[ -n $key[PageDown]  ]] && bindkey - $key[PageDown]   down-line-or-history
#[[ -n $key[Backspace] ]] && bindkey - $key[Backspace]  backward-delete-char
#[[ -n $key[Shift-Tab] ]] && bindkey - $key[Shift-Tab]  reverse-menu-complete

# Finally, make sure the terminal is in application mode when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
#https://wiki.archlinux.org/title/zsh#Key_bindings
#why not use the zsh/terminfo module for key escape sequences?
#https://github.com/romkatv/zsh4humans/issues/7


#Prompting
autoload -U promptinit
promptinit
#all themes: prompt -p
##list themes: prompt -l
#prompt oliver  #oliver theme by `opk'
#prompt clint white cyan red yellow

#set version control system info
#basic git integration
#from man page zshcontrib
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

#cmds to run before issuing ps1
precmd() {
	#psvars=() 
	vcs_info
}

#set XTerm title (see also zsh module `zftp titlebar' and TMUX `set-title')
#chpwd() {
#   [[ -t 1 ]] || return
#   case $TERM in
#     (sun-cmd) print -Pn "\e]l%~\e\\" ;;
#     (*xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a" ;;
#   esac
#}

#First, the easy ones: PS2..4:
# secondary prompt, printed when the shell needs more information to complete a command.
#PS2='\`%_> '
# selection prompt used within a select loop.
#PS3='?# '
# the execution trace prompt (setopt XTRACE). default: '+%N:%i>'
#PS4='+%N:%i:%_> '

#set PS1
#colours
#root user
c0=red
#common user
c1=cyan
#shell sublevels
#OBS: SHLVL config depends on on your specific windowing system!
prompt_ssl_max=3

#PS1="%F{red}%B%(?..%? )%b%F{%(!.${c0}.${c1})}%n%F{white}@%m %40<...<%B%~%b%<< \${vcs_info_msg_0_}%f(%!%(1j.%%%j.))%F{yellow}%(${prompt_ssl_max}L.+.)%f%# "
PS1="%F{red}%B%(?..%? )%b%F{%(!.${c0}.${c1})}%n%F{white}@%m %40<...<%B%~%b%<< \${vcs_info_msg_0_}%f%(1j.(%%%j).)%F{yellow}%(${prompt_ssl_max}L.+.)%f%# "
#set right side ps1
RPS1='%(?.%(t.Ding!.%D{%K:%M}).:()'
unset c0 c1 prompt_ssl_max

#PS1='%(t.Ding!.%D{%L:%M})%# '
#PS1='%(?..(%?%))%# '
#PS1='%(2L.+.)%# '
#PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '
#Brazilian flag
#PS1='%K{green}%F{yellow}%B<%F{blue}•%F{yellow}>%b%f%k%# '
#check themes with prediction: prompt <TAB>
#zsh prompt tips
#https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
#The POSTEDIT parameter is printed whenever the editor exits. This can be
#useful for termcap tricks. To highlight the prompt and command line while
#leaving command output unhighlighted, try this:
#POSTEDIT=`echotc se`  PROMPT='%S%% '
#https://zsh.sourceforge.io/Intro/intro_14.html


#GRML-zsh-pony
#https://grml.org/zsh-pony/
#Completion System
zmodload zsh/complist
autoload compinit
compinit

#Menu Selection
zstyle ':completion:*' menu select
#OR#
#zstyle ':completion:*' list-prompt
#https://zsh.sourceforge.io/Doc/Release/Completion-System.html
#Tip: Get completion help running 'ctrl-x h'.
#
#Use colors in completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''

#Pick item but stay in the menu
bindkey -M menuselect '+' accept-and-menu-complete
bindkey -M menuselect $key[Insert] accept-and-menu-complete

# accept a completion and try to complete again by using menu
# completion; very useful with completing directories
# by using 'undo' one's got a simple file browser
bindkey -M menuselect '^o' accept-and-infer-next-history

#Shift-tab Perform backwards menu completion
bindkey -M menuselect ${key[Shift-Tab]:-"[Z"} reverse-menu-complete

## use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

#Open editor <C-X C-E>
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
#https://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh


#interval in seconds between checks for login/logout activity
#LOGCHECK=
# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH


#load modules

# autoload zsh modules when they are referenced
zmodload -a zcalc
zmodload -a mapfile
zmodload -a zsh/stat zstat
zmodload -a zmv
#zmodload -a zed  #edit a function in zle
#move and rename files
#{ zmv '(*).mp3' '$1.wma' }


#load zcalc
#autoload -Uz zcalc

#load zargs
autoload -U zargs

#color names
autoload colors && colors

## ZLE tweaks ##
#to list all binded keys, run bindkey

#URL quoting
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
#Disclaimer: annoying when using e.g. http://example.org/foo{1,2,3}.tgz

#exit shell on partial command line
exit_zsh() { exit }
zle -N exit_zsh
bindkey - '^D' exit_zsh

#ctrl+u to kill from cursor to the start of line
#in zsh ctrl+u it deletes whole line
bindkey - '^U' backward-kill-line

#insert octothorpe at beggingin of line
bindkey - '\e\#' pound-insert  #ESC-#

#expand aliases on space
#expand-alias() { zle _expand_alias; zle self-insert;}
#zle -N expand-alias
#bindkey -M main ' ' expand-alias

#file manager key binds
#first comes back in directory history (Alt+Left)
#the second let the user go to the parent directory (Alt+Up)
cdUndoKey()
{
	popd
	zle reset-prompt
	echo
	ls
	zle reset-prompt
}
cdParentKey()
{
	pushd ..
	zle reset-prompt
	echo
	ls
	zle reset-prompt
}
zle -N cdParentKey
zle -N cdUndoKey
bindkey - '^[[1;3A' cdParentKey
bindkey - '^[[1;3D' cdUndoKey
#https://wiki.archlinux.org/index.php/Zsh#Configuration_frameworks


#custom accept line
accept-line-hack()
{
	CURSORLAST=$CURSOR
	zle .accept-line
}
#replace all instances of accept-line() with accept-line-hack()
zle -N accept-line accept-line-hack
#revert with: `zle -A .accept-line accept-line'
#mailing list, 22 May 1997

#custom up and down history fun
#history up and down, readline-like
up-history-hack()
{
	((CURSOR==${#BUFFER} || CURSOR==CURSORLAST)) || local curs=$CURSOR
	[[ $BUFFER = *$'\n'* ]] && ((CURSOR==CURSORLAST)) && BUFFER= LBUFFER=
	if ((! CURSOR || CURSOR==${#BUFFER} || CURSOR==CURSORLAST))
	then
 		local curs=$CURSOR
		CURSOR=${#BUFFER} zle .${1:-up}-line-or-search
	else
		zle .${1:-up}-line-or-search $LBUFFER
		CURSORLAST=
	fi
	CURSOR=${CURSORLAST:-${curs:-${#BUFFER}}}
}
down-history-hack()
{
	zle up-history-hack down
}
#!#multiline buffers may present problems
zle -N up-history-hack
zle -N down-history-hack
bindkey - $key[Up]   up-history-hack
bindkey - $key[Down] down-history-hack
#get the hard coded binding with `Ctrl+V + <KEY>'


# Create directory under cursor or the selected area (from grml zsh)
# Press ctrl-xM to create the directory under the cursor or the selected area.
# To select an area press ctrl-@ or ctrl-space and use the cursor.
# Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
# directory does not exist yet -> press ctrl-XM and problem solved
inplaceMkDirs() {
	local PATHTOMKDIR
	if ((REGION_ACTIVE==1)); then
		local F=$MARK T=$CURSOR
		if [[ $F -gt $T ]]; then
			F=${CURSOR}
			T=${MARK}
		fi
		# get marked area from buffer and eliminate whitespace
		PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
		PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
	else
		local bufwords iword
		bufwords=(${(z)LBUFFER})
		iword=${#bufwords}
		bufwords=(${(z)BUFFER})
		PATHTOMKDIR="${(Q)bufwords[iword]}"
	fi
	[[ -z "${PATHTOMKDIR}" ]] && return 1
	PATHTOMKDIR=${~PATHTOMKDIR}
	if [[ -e "${PATHTOMKDIR}" ]]; then
		zle -M " path already exists, doing nothing"
	else
		zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
		zle end-of-line
	fi
}
zle -N inplaceMkDirs
bindkey - '^xM' inplaceMkDirs
# mkdir -p <dir> from string under cursor or marked area


#Edit the current line in \kbd{\$EDITOR}
autoload edit-command-line
zle -N edit-command-line
bindkey - '\ee' edit-command-line

#k# Insert Unicode character
# usage example: 'ctrl-x i' 00A7 'ctrl-x i' will give you an §
# See for example http://unicode.org/charts/ for unicode characters code
autoload insert-unicode-char
zle -N insert-unicode-char
bindkey - '^XU' insert-unicode-char

#The following binds insert-composed-char to F5 on my keyboard:
autoload -Uz insert-composed-char
zle -N insert-composed-char
bindkey '\e[15~' insert-composed-char
#https://zsh.sourceforge.io/FAQ/zshfaq05.html

# add a command line to the shells history without executing it
function commit-to-history () {
    print -rs ${(z)BUFFER}
    zle send-break
}
zle -N commit-to-history
bindkey - '^x^h' commit-to-history

# press "ctrl-x d" to insert the actual date in the form yyyy-mm-dd
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp
#k# Insert a timestamp on the command line (yyyy-mm-dd)
bindkey - '^xd' insert-datestamp

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word
#k# jump to after first word (for adding options)
bindkey - '^x1' jump_after_first_word

# Do history expansion on space:
#bindkey -s ' ' magic-space

## set command prediction from history, see 'man 1 zshcontrib'
autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey - '^X^Z' predict-on
bindkey - '^Z' predict-off
#from zsh mailing list:
zstyle :predict verbose yes
zstyle :predict cursor key
zstyle ':completion:predict:*' completer _oldlist _complete _ignored _history _prefix
zstyle :predict toggle yes

## press ctrl-q to quote line:
#mquote () {
#      zle beginning-of-line
#      zle forward-word
#      # RBUFFER="'$RBUFFER'"
#      RBUFFER=${(q)RBUFFER}
#      zle end-of-line
#}
#zle -N mquote && bindkey - '^q' mquote

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
#WORDCHARS=.
#WORDCHARS='*?_[]~=&;!#$%^(){}'
#WORDCHARS='${WORDCHARS:s@/@}'

#bindkey - '\eq' push-line-or-edit

# Here are still a few hardcoded escape sequences; Special sequences
# like Ctrl-<Cursor-key> etc do suck a fair bit, because they are not
# standardised and most of the time are not available in a terminals terminfo entry.
# hard coded key bindings like these are discouraged.
# use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on the command line.
# URxvt sequences:
bindkey - '\eOc' forward-word
bindkey - '\eOd' backward-word
# These are for xterm:
bindkey - '\e[1;5C' forward-word
bindkey - '\e[1;5D' backward-word
## the same for alt-left-arrow and alt-right-arrow
# URxvt again:
bindkey - '\e\e[C' forward-word
bindkey - '\e\e[D' backward-word
# Xterm again:
bindkey - '^[[1;3C' forward-word
bindkey - '^[[1;3D' backward-word
# Also try ESC Left/Right:
bindkey - '\e'$key[Right] forward-word
bindkey - '\e'$key[Left]  backward-word


#GRML-zshrc
# completion system

# A newly added command may not be found or will cause false
# correction attempts, if you got auto-correction set.
#zstyle ':completion:*' rehash true

# case insensitivity
zstyle ":completion:*" matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# case-insensitive -> partial-word (cs) -> substring completion:
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'  
#https://github.com/seebi/zshrc/blob/master/completion.zsh

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'       original true

# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# format on completion
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
# zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false

# activate menu
zstyle ':completion:*:history-words'   menu yes

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# match uppercase from lowercase
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''

# if there are more than 5 options allow selecting from a menu
zstyle ':completion:*'               menu select=5
#OR# don't use any menus at all
#setopt NO_AUTO_MENU

zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# on processes completion complete all user processes
zstyle ':completion:*:processes'       command 'ps -au$USER'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*'                 verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'    verbose false

# set format for warnings
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
#zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
#zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin
                                           #/usr/X11R6/bin

## compsys related snippets ##
# provide .. as a completion
zstyle ':completion:*' special-dirs ..
## the default grml setup provides '..' as a completion. it does not provide
## '.' though. If you want that too, use the following line:
#zstyle ':completion:*' special-dirs true

# command for process lists, the local web server details and host completion
zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

# host completion
[[ -r ~/.ssh/config ]] \
&& _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
[[ -r ~/.ssh/known_hosts ]] \
&& _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] \
&& : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

if [[ -n $HOST ]]
then
  localname=$HOST
elif command -v hostname ; then
  localname=$(hostname)
elif command -v hostnamectl ; then
  localname=$(hostnamectl --static)
else
  localname=$(uname -n)
fi

hosts=(
    "${localname}"
    "$_ssh_config_hosts[@]"
    "$_ssh_hosts[@]"
    "$_etc_hosts[@]"
    localhost
)
unset localname _ssh_config_hosts _ssh_hosts _etc_hosts
zstyle ':completion:*:hosts' hosts $hosts
# TODO: so, why is this here?
#  zstyle '*' hosts $hosts


## correction
setopt CORRECT
# some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
#if [[ "$NOCOR" -gt 0 ]] ; then
#    zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
#    setopt nocorrect
#else
#    # try to be smart about when to use what completer...
#    setopt correct
#    zstyle -e ':completion:*' completer '
#        if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
#            _last_try="$HISTNO$BUFFER$CURSOR"
#            reply=(_complete _match _ignored _prefix _files)
#        else
#            if [[ $words[1] == (rm|mv) ]] ; then
#                reply=(_complete _files)
#            else
#                reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
#            fi
#        fi'
#fi


# global aliases (expand whatever their position)
alias -g :2L='|& less'
alias -g :C='| wc -l'
alias -g :E='2> /dev/null'
alias -g :G='|& grep'
alias -g :H='| head'
alias -g :L='| less'
alias -g :N='&> /dev/null'
alias -g :O='> /dev/null'
alias -g :S='| sort'
alias -g :SN='| sort -n'
alias -g :SU='| sort -u'
alias -g :T='| tail'
alias -g :V='|& vim -'
#alias co='./configure && make && sudo make install'
#unglobalalias() {
# 	for i in ':E' ':C' ':H' ':L' ':S' ':SN' ':T'; unalias $i
#}
#https://matt.blissett.me.uk/linux/zsh/zshrc

alias - -="fg %-"
#http://zsh.sourceforge.net/FAQ/zshfaq02.html


# 'hash' some often used directories
#maybe CDABLE_VARS must be enabled
hash -d arq=~/arq
hash -d bak=~/bak
hash -d bin=~/bin
hash -d dl=~/Downloads
hash -d Doc=~/Documents
hash -d docs=~/arq/docs
hash -d markets=~/bin/markets
hash -d media=/run/media
hash -d mkt=~/bin/markets
hash -d tmp=~/tmp
hash -d w=~/Downloads

# start
hash -d doc=/usr/share/doc
hash -d linux=/lib/modules/$(command uname -r)/build/
hash -d log=/var/log
hash -d slog=/var/log/syslog
hash -d src=/usr/src
hash -d www=/var/www

# aliases
alias la=' ls -la'
alias ll=' ls -l'
alias lh=' ls -hAl'
alias l='ls -l'
alias llog="sudo journalctl"
alias tlog="sudo journalctl -f"

# Execute \kbd{du -sch}
alias da='du -sch'

# listing stuff
# Execute \kbd{ls -lSrah}
alias dir="command ls -lSrah"
# Only show dot-directories
alias lad='command ls -d .*(/)'
# Only show dot-files
alias lsa='command ls -a .*(.)'
# Only files with setgid/setuid/sticky flag
alias lss='command ls -l *(s,S,t)'
# Only show symlinks
alias lsl='command ls -l *(@)'
# Display only executables
alias lsx='command ls -l *(*)'
# Display world-{readable,writable,executable} files
alias lsw='command ls -ld *(R,W,X.^ND/)'
# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
# Only show directories
alias lsd='command ls -d *(/)'
# Only show empty directories
alias lse='command ls -d *(/^F)'
# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"
# Display the ten newest directories and ten newest .directories
alias lsnewdir="command ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
# Display the ten oldest directories and ten oldest .directories
alias lsolddir="command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"

# Remove current empty directory. Execute \kbd{cd ..; rmdir \$OLDCWD}
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'


#bins -- list all executable files in $PATH as called by basename
bins()
{
	rehash
	whence -p ${(kon)commands}
}

#base NUM -- convert between bases
#20jul2014  +chris+  zsh function
base()
{
	setopt LOCAL_OPTIONS C_BASES OCTAL_ZEROES
	printf "%s = %08d %d 0%o 0x%x\n" $1 ${$(([#2] $1))#2\#} $(($1)) $(($1)) $(($1))
}


# ltime - start and run time of last commands
# 05feb2018  +leah+  use tail -n
ltime()
{
	fc -liDI | tail -n ${1:-10}
}

# clot - fill screen with garbage, as visual separator
# 17aug2015  +chris+
# 11mar2016  +chris+ print seperate lines
clot()
{
	head -c $((LINES*COLUMNS)) </dev/urandom |
		LC_ALL=C tr '\0-\377' ${(l:256::.*o@:)} |
		fold -w $COLUMNS
}

#zsh semaphore
#usage: semaphore [maximum_jobs] [sleep_time]
#example: while true ;do semaphore ; (cmd ;cmd) & done
semaphore()
{
	while ((${#jobstates[@]} > ${1:-4})) ;do sleep ${2:-0.2} ;done
}

# cd to directory and list files
function cl () {
    emulate -L zsh
    cd $1 && ls -a
}

# Create Directory and \kbd{cd} to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
    emulate -L zsh
    print -l - *(a-${1:-1})
}

# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
    emulate -L zsh
    print -l - *(c-${1:-1})
}

# List files which have been modified within the last {\it n} days, {\it n} defaults to 1
function modified () {
    emulate -L zsh
    print -l - *(m-${1:-1})
}

#zcalc () { print $(( ans = ${1:-ans} )) }
#zcalch () { print $(( [#16] ans = ${1:-ans} )) }
#zcalcd () { print $(( [#10] ans = ${1:-ans} )) }
#zcalco () { print $(( [#8] ans = ${1:-ans} )) }
#zcalcb () { print $(( [#2] ans = ${1:-ans} )) }
#this last one lets you calculate the ascii value of a single character
#zcalcasc () { print $(( [#16] ans = ##${1:-ans} )) }

#When you hit return it saves the cursor position, and then it's restored when
#moving to the last command in the history
#https://www.zsh.org/mla/users/2008/msg00607.html

#sometimes, I will start typing a command, realize I do not want to execute
#it, hit CTRL-C, only to realize I would have saved a lot of typing if I
#had instead modified it. What I would love to see is a feature that
#holds onto the last buffer content and revives it into ZLE, so to speak.
#alt-q does the job. If don't, just add to zshrc;
#bindkey - 'ESC-q' push-line

#from alan third
most_useless_use_of_zsh()
{
    local lines columns colour a b p q i pnew
    ((columns=COLUMNS-1, lines=LINES-1, colour=0))
    for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
        for ((a=-2.0; a<=1; a+=3.0/columns)) do
            for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
                ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
            done
            ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}

#fun
#usage:  haha [word] [+interger]
haha() ( x=.2; y=0.00000002; i=$x; [[ $1 = [0-9+]* ]] && set - "$2" $1; while { i=$(( i ${sign:--} ( i / ${2:-10} ) )) } { print -n "\e[${RANDOM:1:1};${RANDOM:1:2};${RANDOM:1:2}m${1:-haha?}\e[0m"; ((i<y)) && sign=+; ((i>=x)) && sign=- ;sleep $i } )

#print a list of html entities
htmlentities()
{
	(( $1 )) || set -- 127 0

	{
	echo 'mapped entities<p>'
	paste <(printf '%s\n' \#{${2}..${1}}) <(printf '%s\n' \&\#{${2}..${1}}\; ) | w3m -dump -T text/html

	echo
	echo '<br><br>entity glob<p>'
	printf '%s\n' \&\#{${2}..${1}}\;
	} | w3m -dump -T text/html
}
#see also:
#recode html..ascii
#xmlstarlet unesc #this works for &amp; &lt; etc only


## log out? set timeout in seconds...
## ...and do not log out in some specific terminals:
#if [[ "${TERM}" == ([Exa]term*|rxvt|dtterm|screen*) ]] ; then
#    unset TMOUT
#else
#    TMOUT=1800
#fi

#print name of exit code
#print $signals[$?^128+1]

#quote positional args '$@'
#${(q)^^@}
#${(qq)^^@}

#get name of last file matching the glob?
#file*.ext([-1])

#read prompting mechanism
#read 'foo?prompt: '
#read '?Delete these merged branches? '

#command : to create empty file
#$ : >file

#array elements one per line
#echo "${ARRAY[@]}" | xargs -n 1 command
#echo ${(j:\n:)ARRAY} | command
#print -l "$a[@]"
#command "$ARRAY[@]"  #if feasible

#the rule is:  define first those aliases you expect to use in the body
#of a function, but define the function first if the alias has the same
#name as the function.

## get top 10 shell commands:
#alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

## Handy functions for use with the (e::) globbing qualifier (like nt)
#contains() { grep -q "$*" $REPLY }
#sameas() { diff -q "$*" $REPLY &>/dev/null }
#ot () { [[ $REPLY -ot ${~1} ]] }

## List all occurrences of programm in current PATH
#plap() {
#    emulate -L zsh
#    if [[ $# = 0 ]] ; then
#        echo "Usage:    $0 program"
#        echo "Example:  $0 zsh"
#        echo "Lists all occurrences of program in the current PATH."
#    else
#        ls -l ${^path}/*$1*(*N)
#    fi
#}

#from zsh mailing list
#CHECK $ZDOTDIR/functions.d/ FOR DATE FUNCTIONS!
#load module:
#{ zmodload zsh/datetime ;}
#function ctime {
#  # Print the current or argument time in standard format
#  local time=${1:-$EPOCHSECONDS}
#  strftime "%a %b %e %H:%M:%S %Y" $time
#}
#function starttime {
#  # Print the time this shell was started
#  # (doesn't work if SECONDS has been reset)
#  typeset -i SECONDS=$SECONDS   # No floating point
#  ctime $((EPOCHSECONDS - SECONDS))
#}
#function rfcdate {
#  # Like GNU "date -R"
#  strftime "%a, %e %b %Y %H:%M:%S %z" $EPOCHSECONDS
#}
#As this doesn't work without a version of strftime that supports the
#  nonstandard "%z", here's a replacement:
#function rfcdate {
#    # As much like GNU "date -R" as possible
#    if [[ ${(%):-"%D{%z}"} == [-+]<-> ]]
#    then strftime "%a, %e %b %Y %H:%M:%S %z" $EPOCHSECONDS
#    else strftime "%a, %e %b %Y %H:%M:%S %Z" $EPOCHSECONDS
#    fi
#}
#
# matchtime attempts to match a date string against a number of seconds
# since the epoch (as returned by zsh/datetime's $EPOCHSECONDS).
# Input: a line and an epoch time, which defaults to now.
# Returns: 0 if the line contains today's date, else 1.
# Tries various date formats: see comments below.
# (Should really be called matchdate, in fact.)
#matchtime() { <see mailing lists> }

#And no, you can't assume that users will have zsh/system. Which modules
##are available to zsh is up to the packager, but these
#are the ones that are linked by default with --disable-dynamic:
#
#zsh/compctl 	zsh/complete 	zsh/complist 	zsh/computil
#zsh/datetime 	zsh/main 	zsh/parameter 	zsh/rlimits
#zsh/sched 	zsh/termcap 	zsh/zle 	zsh/zleparameter
#zsh/zutil
#
#So i think those are essentially the 'core' modules. You can probably
#include zsh/langinfo and zsh/terminfo in most cases too.
#dana
#
#specifies that builtin strftime and parameter EPOCHSECONDS are to be
#autoloaded from the module zsh/datetime, but that no other features
#from zsh/datetime will be enabled without being specifically mentioned.
zmodload -aF zsh/datetime b:strftime p:EPOCHSECONDS

#c-style
#if ((n==2)) { 	print hello }
#while ((range-- >0)) { print hello }
#brackets are not even necessary to run a single command!


#sources

#.rc extensive aliases ans functions
#command-not-found hook from pkgfile
#zsh syntax highliting plugin
for f in \
	/usr/share/doc/pkgfile/command-not-found.zsh \
	/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do [[ -e "$f" ]] && . "$f"
done ;unset f

#highlight brackets
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)  #(pattern)


#declare user-overidable styles
#ZSH_HIGHLIGHT_STYLES[default]=none
#ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
#ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green
#ZSH_HIGHLIGHT_STYLES[alias]=none
#ZSH_HIGHLIGHT_STYLES[builtin]=none
#ZSH_HIGHLIGHT_STYLES[function]=none
#ZSH_HIGHLIGHT_STYLES[command]=none
#ZSH_HIGHLIGHT_STYLES[precommand]=none
#ZSH_HIGHLIGHT_STYLES[commandseparator]=none
#ZSH_HIGHLIGHT_STYLES[hashed-command]=none
#ZSH_HIGHLIGHT_STYLES[path]=none
#ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
#ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
#ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
#ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
#ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
#ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
#ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
#ZSH_HIGHLIGHT_STYLES[assign]=none
#https://blog.patshead.com/2012/01/using-and-customizing-zsh-syntax-highlighting-with-oh-my-zsh.html
#https://blog.aktsbot.in/color-me-baby.html


#aliasing `mail' may conflict with Z-shell autocompletion
compdef _files mail
#https://unix.stackexchange.com/questions/677280/disable-zsh-smart-autocompletion-for-gem-command-but-keep-ordinary-path-compl

