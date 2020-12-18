#!/bin/bash
# v0.4.7  dec/2020  by castaway
# create base-58 address types from public keys

#defaults
#user-side, set $VER
#public address version byte
VERDEF=00
#private address version byte
VERPRIDEF=80

#script name
SN="${0##*/}"

#make sure locale is set correctly
export LC_NUMERIC=C

#help
HELP="$SN - create base-58 address types from public keys


DESCRIPTION
	$SN [-ae] [-vNUM] STRING..
	$SN [-edr] STRING..
	$SN [-cpw] STRING..
	$SN -h


	manipulate addresses from hex strings. set multiple STRINGS as
	positional parameters or send them via stdin, one per line.

	WARNING: EXPERIMENTAL SCRIPT!


	Public keys

	option -a skips making hash160 of STRING when creating
	a base-58 address from it.

	option -d prints the double-sha256 sum of STRING only.

	option -r prints the hash160 of STRING only.

	option -vNUM sets version byte, in which NUM is an integer
	such as 00 or 05.  evironment \$VER is read, defaults=${VERDEF} .


	Private keys

	option -c checksums private keys.

	option -p generates a private key from seed; user may sha256
	an image, audio file to use the hash as input.


	Miscellaneous

	option -e for some verbose and option -h for this help page.


SEE ALSO
	some embeded functions of this script are from grondilu's
	project, see <https://github.com/grondilu/bitcoin-bash-tools>.

	for basic information on making addresses, see bitcoin wiki:
	<https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses>.

	address prefixes
	<https://en.bitcoin.it/wiki/List_of_address_prefixes>

	graphical address generator (for studying purposes only!)
	<https://royalforkblog.github.io/2014/08/11/graphical-address-generator/>

	BIP39 Tool
	<https://github.com/iancoleman/bip39>

	private key generation from WIF
	<


ABOUT & WARRANTY
	this is a wrapper around \`\`some'' functions from
	grondilu's bitcoin-bash-tools. the script has got some
	original functions, too.

	be aware this script is for studying purposes so there is
	no guarantee this is working properly.

	licensed under the gnu general public license 3 or better
	and is distributed without support or bug corrections.
	grondilu's bitcoin-bash-tools functions are embedded in
	this script.
	
	packages GNU dc (GNU coreutils), openssl, xxd, sha256sum
	and bash version 4 or above are required.

	if you found this programme interesting, please consider
	sending me a nickle!  =)
  
		bc1qlxm5dfjl58whg6tvtszg5pfna9mn2cr2nulnjr


USAGE EXAMPLES
	1) get hash160 of address:
		$ $SN -r 12c6DSiU4Rq3P4ZxziKxzrL5LmMBrzjrJX

		0119b098e2e980a229e139a9ed01a469e518e6f26


	2) make public address from hex:
		#from coinbase transaction at block 1
		$ $SN 0496b538e853519c726a2c91e61ec11600ae1390813a627c66fb8be7947be63c52da7589379515d4e0a604f8141781e62294721166bf621e73a82cbf2342c858ee

			12c6DSiU4Rq3P4ZxziKxzrL5LmMBrzjrJX

		#from txid fe6c48bbfdc025670f4db0340650ba5a50f9307b091d9aaa19aa44291961c69f  
		$ $SN -v05 00142b2296c588ec413cebd19c3cbc04ea830ead6e78
		$ VER=05 $SN 00142b2296c588ec413cebd19c3cbc04ea830ead6e78
			
			3FfQGY7jqsADC7uTVqF3vKQzeNPiBPTqt4


OPTIONS
	Public keys
	-a 	Avoid making hash160.
	-d 	Print double sha256 sum only.
	-r 	Print hash160 only.
	-v NUM 	Set version byte, defaults=${VERDEF} .
	Private keys
	-c 	check Wallet Import Format private key.
	-p 	generate private key from seed.
	-v NUM 	Set version byte, defaults=${VERPRIDEF} .
	Misc
	-e 	Verbose mode.
	-h 	Print this help page."


#functions

#please check grondilu's repository for bitcoin-bash-tools
#
# Various bash bitcoin tools
#
# requires dc, the unix desktop calculator (which should be included in the
# 'bc' package)
#
# This script requires bash version 4 or above.
#
# This script uses GNU tools.  It is therefore not guaranted to work on a POSIX
# system.
#
# Copyright (C) 2013 Lucien Grondin (grondilu@yahoo.fr)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

pack() {
    echo -n "$1" |
    xxd -r -p
}
unpack() {
    local line
    xxd -p |
    while read line; do echo -n ${line/\\/}; done
}

declare -a base58=(
      1 2 3 4 5 6 7 8 9
    A B C D E F G H   J K L M N   P Q R S T U V W X Y Z
    a b c d e f g h i j k   m n o p q r s t u v w x y z
)
unset dcr; for i in {0..57}; do dcr+="${i}s${base58[i]}"; done

decodeBase58() {
    local line
    echo -n "$1" | sed -e's/^\(1*\).*/\1/' -e's/1/00/g' | tr -d '\n'
    dc -e "$dcr 16o0$(sed 's/./ 58*l&+/g' <<<$1)p" |
    while read line; do echo -n ${line/\\/}; done
}
encodeBase58() {
    local n
    echo -n "$1" | sed -e's/^\(\(00\)*\).*/\1/' -e's/00/1/g' | tr -d '\n'
    dc -e "16i ${1^^} [3A ~r d0<x]dsxx +f" |
    while read -r n; do echo -n "${base58[n]}"; done
}

checksum() {
    pack "$1" |
    openssl dgst -sha256 -binary |
    openssl dgst -sha256 -binary |
    unpack |
    head -c 8
}

checkBitcoinAddress() {
    if [[ "$1" =~ ^[$(IFS= ; echo "${base58[*]}")]+$ ]]
    then
        local h="$(decodeBase58 "$1")"
        checksum "${h:0:-8}" | grep -qi "^${h:${#h}-8}$"
    else return 2
    fi
}

hash160() {
    openssl dgst -sha256 -binary |
    openssl dgst -rmd160 -binary |
    unpack
}

hexToAddress() {
    local x="$(printf "%2s%${3:-40}s" ${2:-00} $1 | sed 's/ /0/g')"
    encodeBase58 "$x$(checksum "$x")"
    echo
}


#script original funcs

#convert hex to address
addrf()
{
	#make hash160 of input?
	if (( OPTHASH == 0 ))
	then
		#make hash160
		HASH160="$( pack "$1" | hash160 )"

		#verbose?
		if (( OPTVERBOSE ))
		then
			#print hash160
			echo "hash160: $HASH160"
		fi
	fi

	#convert to address
	hexToAddress "${HASH160:-$1}" "$VER"
}

#double sha256 string
#main func
dsha256fmain()
{
	echo -n "$1" | sha256sum |
		cut -c1-64 | xxd -r -p |
		sha256sum | cut -c1-64
}
#helper func
dsha256f()
{
	if (( OPTVERBOSE ))
	then
		#verbose
		sha256="$( dsha256fmain "$1" )"
		echo "dsha256: $sha256"
	else
		#simple 
		dsha256fmain "$1"
	fi
}
#https://btcleak.com/2020/06/10/double-sha256-in-bash-and-python/

#main loop
mainf()
{
	#skip empty strings/lines?
	#[[ -z "$1" ]] && return 1
	
	#select options
	if (( OPTDSHA ))
	then
		#double sha256 strings
		dsha256f "$1"

	elif (( OPTREV ))
	then
		#-r make hash160 of strings
		revf "$1"
	else
		#default func
		addrf "$1"
	fi
}

#reverse direction
#get a hash160 from address
revf()
{
	#decode base58,
	HASH160="$( decodeBase58 "$1" )"

	#remove byte number and checksum
	HASH160="$( sed -E 's/^.?.(.{40}).{8}$/\1/' <<< "$HASH160" )"

	if (( OPTVERBOSE ))
	then
		#verbose
		echo "hash160: ${HASH160,,}"
	else
		#simple
		echo "${HASH160,,}"
	fi
}

privkeyf()
{
	local input sha256 step hx cksum

	input="${*^^}"
	if grep -E '^[A-Fa-f0-9]{64}$' <<<"$input"
	then
		sha256=( "$input" )
	else
		sha256=( $( sha256sum <<<"$input") )
		
		#echo "Invalid sha256 sum input -- $input" >&2
		#exit 1
	fi
	echo "Input_string: \"$input\""
	echo "Sha256(seed): \"${sha256[0]^^}\""

	step="$VER${sha256[0]^^}"
	hx="$(
		pack "$step" |
		openssl dgst -sha256 -binary |
		openssl dgst -sha256 -binary |
		unpack 
	)"
	cksum="$( head -c8 <<<"$hx" )"

	encodeBase58 "$step$cksum"
	echo
}
#https://en.bitcoin.it/wiki/Wallet_import_format
#https://gist.github.com/t4sk/ac6f2d607c96156ca15f577290716fcc
#http://gobittest.appspot.com/PrivateKey
#https://bitcoin.stackexchange.com/questions/8247/how-can-i-convert-a-sha256-hash-into-a-bitcoin-base58-private-key

wcheckf()
{
	local a b c d cksum hx 

	#Does private key start with 5 or ef
	if [[ "$1" != 5* ]] &&
		[[ "${1^^}" != EF* ]]
	then
		echo "err -- Wallet Import Format key is required" >&2
		return 1
	fi
	
	#Convert it to a string using Base58Check encoding
	a="$( decodeBase58 "$1" )"

	#Drop the last 4 checksum bytes from the byte string
	b="${a%????????}"
	
	#Drop first 2 bytes from the byte string
	c="${a/$b}"

	#does it start with 0x80 byte?
	d="$( cut -c1,2 <<<"$a" )"
	if [[ "$d" != "$VER" ]]
	then
		echo "err: byte string from key does not start with $VER -- $1" >&2
		return 1
	fi
	
	#Convert string to byte string and
	#perform SHA-256 hash on the shortened string 
	hx="$(
		pack "$b" |
		openssl dgst -sha256 -binary |
		openssl dgst -sha256 -binary |
		unpack 
	)"
	
	#Take the first 4 bytes of the second SHA-256 hash, this is the checksum 
	cksum="$( head -c8 <<<"$hx" )"

	#uppercase values
	c="${c^^}"
	cksum="${cksum^^}"

	#Make sure $cksum matches $c
	#If they are the same, and the byte string from point 2 starts
	#with 0x80 (0xef for testnet addresses), then there is no error
	if [[ "$cksum" == "$c" ]]
	then
		echo "Validation pass -- $1"
	else
		echo "Invalid BTC address -- $1" >&1
		return 1
	fi
}

wifkeyf()
{
	#Does private key start with 5 or ef
	if [[ "$1" != 5* ]] ||
		[[ "${1^^}" != EF* ]]
	then
		echo "err: Wallet Import Format key is required" >&2
		return 1
	fi
	
	#Convert it to a string using Base58Check encoding
	set -- "$( decodeBase58 "$1" )"

	#Drop the last 4 checksum bytes from the byte string
	set -- "${*%????????}"
	
	#Drop first 2 bytes from the byte string
	set -- "${*#??}"

	#print private key
	echo "$*"
}


#parse opts
while getopts adehrv:cpw c
do
	case $c in
		a)
			#don't make hash160 of input
			OPTHASH=1
			;;
		d)
			#double sha256 string
			OPTDSHA=1
			;;
		e)
			#verbose
			OPTVERBOSE=1
			;;
		h)
			#print script version
			while IFS=  read -r
			do
				[[ "$REPLY" = \#\ v[0-9]* ]] && break
			done < "$0"
			echo "$REPLY"

			#print help
			echo "$HELP"
			exit 0
			;;
		r)
			#reverse direction
			#print hash160 of string
			OPTREV=1
			;;
		v)
			#byte version
			VER="${OPTARG:-${VERDEF}}"
			VEROPT=1
			;;
		c)
			#check private key
			OPTC=1
			VERDEF="$VERPRIDEF"
			;;
		p)
			#make a privy key from seed
			OPTP=1
			VERDEF="$VERPRIDEF"
			;;
		w)
			#WIF to private key
			OPTW=1
			;;
		?)
			#illegal opt
			exit 1
			;;
	esac
done
shift $(( OPTIND - 1 ))
unset c


#required packages
for PKG in jq openssl xxd
do
	if ! command -v "$PKG" &>/dev/null
	then
		echo "$SN: err  -- $PKG is required" >&2
		exit 1
	fi
done
unset PKG

#check bash version
if (( BASH_VERSINFO[0] < 4 ))
then
    echo "$SN: err  -- bash version 4 or above required" >&2
    exit 1
fi

#set option function
if (( OPTC ))
then
	#check private key sum
	mainf() { wcheckf "$@" ;}
elif (( OPTP ))
then
	#create private key from seed
	mainf() { privkeyf "$@" ;}
elif (( OPTW ))
then
	#WIF to privy key
	mainf() { wifkeyf "$@" ;}
fi

#check $VER and incompatible options
if [[ "$VER" = *[a-zA-Z]* ]] ||
	(( ${#VER} > 2 ))
then
	echo "$SN: warning: user-set byte version -- $VER" >&2
elif (( VEROPT )) && {
	(( OPTREV )) ||	(( OPTDSHA ))
}
then
	echo "$SN: err  -- incompatible options" >&2
	exit 1
fi

#consolidate version byte option
VER="${VER:-${VERDEF}}"

#default function
#loop through strings
#is there any postional argument?
if (( $# ))
then
	for ARG in "$@"
	do
		mainf "$ARG"
	done
#is stdin taken?
elif [[ ! -t 0 ]]
then
	#dont mangle lines at \\EOL
	while IFS=  read -r
	do
		mainf "$REPLY"
	done
else
	#fail
	echo "$SN: user input required" >&2
	exit 1
fi

