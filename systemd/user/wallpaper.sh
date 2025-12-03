#!/usr/bin/bash
# Download and Set New Wallpaper XFCE4
# v0.2  Dec/2025  mountaineerbr


#curl with custom parameters
curlf()
{
	curl -f -L --compressed --insecure --cookie non-existing --header "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36" "$@";
}

#Solar Dynamics Observatory (SDO)
#Geostationary Operational Environmental Satellite (GOES)
sdof()
{
	typeset dir_sdo dir_goes filename filepath lengths sectors url var

	dir_sdo=${PICTURES_DIR}/SDO
	dir_goes=${PICTURES_DIR}/GOES

	[[ -d $dir_sdo ]] || mkdir -pv -- "$dir_sdo" || return;
	[[ -d $dir_goes ]] || mkdir -pv -- "$dir_goes" || return;


	if ((RANDOM%2))
	then
		lengths=(
			latest_1024_0094.jpg
			latest_1024_0131.jpg
			latest_1024_0211.jpg
			latest_1024_0335.jpg
			latest_1024_211193171.jpg
			latest_1024_HMIB.jpg
			latest_1024_HMIBC.jpg
			latest_1024_HMID.jpg
			latest_1024_1600.jpg
		)

		filename="${lengths[RANDOM%${#lengths[@]}]}"
		filepath="${dir_sdo}/${filename:-${lengths[0]}}"
		url="https://sdo.gsfc.nasa.gov/assets/img/latest/${filepath##*/}"
	else

		if ((RANDOM%2))
		then
			lengths=(Fe094 Fe131 Fe171 Fe195 Fe284 He304 R2G4B3);
			url="https://cdn.star.nesdis.noaa.gov/GOES19/SUVI/FD/${lengths[RANDOM%${#lengths[@]}]}"

		else
			sectors=(cam can car cgl eep eus ga mex na ne nr nsa pnw pr psw se smv sp sr ssa taw umv);
			url="https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR/${sectors[RANDOM%${#sectors[@]}]}/GEOCOLOR";
		fi;

		if var=$(curlf "${url%%/}/")
		then 
			filename=$(sed -En 's/.*"(20[23][0-9_A-Za-z-]*1808x1808.jpg)".*/\1/p' <<<$var | sed -n -e '$ p');

			[[ $filename = *jpg ]] ||
				filename=$(sed -E -n -e 's/.*"(20[23][0-9_A-Za-z-]*1200x1200.jpg)".*/\1/p' <<<$var | sed -n -e '$ p');
		fi;

		[[ $filename = *jpg ]] || filename="latest.jpg";

		filepath="${dir_goes}/goes_${filename}"
		url="${url}/${filename}"

	fi

	FILEPATH=$filepath;

	curlf -o "$filepath" "$url";

}


#add stamp to the image file
#dependecy: imagemagick
img_stampf()
{
	typeset filepath stamp

	filepath=$1;
	stamp=${filepath%.*} stamp=${stamp##*/};

	! command -v mogrify >/dev/null || [[ ! -s $filepath ]] ||
	  mogrify -pointsize 16 -fill red -gravity SouthEast -annotate +1+1 "$stamp" "$filepath";
}

#Instituto de Pesquisas Meteorológicas (IPMet)
#Centro de Meteorologia de Bauru - FC/Unesp (Southern Brazil)
#Sistema de Tecnologia e Monitoramento Ambiental do Paraná (SIMEPAR)
ipmetf()
{
	typeset filepath filename var

	if ((RANDOM%2))
	then
		#ipmet
		filepath=$(IMGVIEWER=":" ${HOME}/bin/ipmet.sh)
	else
		#simepar
		filepath=$(IMGVIEWER=":" ${HOME}/bin/ipmet.sh -s)
	fi;
	# ipmet.sh downloads and outputs the image filepath!
	
	if [[ -s $filepath ]]
	then
		FILEPATH=$filepath;

		img_stampf "$filepath";

	else
		! echo "err: image path -- $filepath" >&2;
	fi;

}



#output dir
#PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
PICTURES_DIR="${XDG_PICTURES_DIR:-$(xdg-user-dir PICTURES)}"

#make sure output dir exists (may be needed)
[[ -d $PICTURES_DIR ]] || mkdir -pv "$PICTURES_DIR" || exit;


#functions to download images
#variable $FILEPATH must be set here!

sdof "$@";
#ipmetf "$@";


#final check or exit
[[ -s $FILEPATH ]] || exit;
echo "Image File: $FILEPATH" >&2;
#echo "$FILEPATH"; exit;


#set the wallpaper
#note: DBUS may be requried!


#xfce4
#inspiron 15-5557
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/last-image -s "$FILEPATH";

#inspiron 15r-se-7520
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS-1/workspace0/last-image -s "$FILEPATH";


#gnome
#gsettings set org.gnome.desktop.background picture-uri "file://$FILEPATH";


#other environments
#DISPLAY=:0 feh --bg-max "$FILEPATH";
