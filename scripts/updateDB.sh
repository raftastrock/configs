#!/bin/bash

# Text color variables
txtund=$(tput sgr 0 1)       # Underline
txtbld=$(tput bold)          # Bold
cyn=${txtbld}$(tput setaf 6) # cyan
red=${txtbld}$(tput setaf 1) # red
blu=${txtbld}$(tput setaf 4) # blue
gre=${txtbld}$(tput setaf 2) # green
wht=${txtbld}$(tput setaf 7) # white
ylw=$(tput setaf 3)			     # yellow
off=$(tput sgr0)             # Reset

#Helper functions
ear() {
	echo -e "$cyn \$ $@ $off"
	eval "$@"
}

spacer() { echo -e "$ylw \n-----------\n $off" ; }

isDebian=$(python -mplatform | grep -qie debian -qie ubuntu && echo true || echo false)
isFedora=$(python -mplatform | grep -qi fedora && echo true || echo false)

checkFile() {
	if [ ! -f "$1" ]; then
		echo -e "$ylw x $1 file does not exist in local dir $off"

		echo -e "$blu ===> Downloading $1 file from mirror$off"

		ear $2

		if ! [ -z "$3" ]; then
			ear "$3"
		fi

	else
		echo -e "$gre ✓ $1 file already exists $off"

		if ! [ -z "$3" ]; then
			ear "$3"
		fi
	fi

	spacer
}

checkSoftware() {
	if ! [ -x "$(command -v $1)" ]; then
		echo -e "$red $1 is not installed $off"

		echo -e "$blu ===> Installing $1 $off"

		if [ $isDebian == "true" ]; then
			ear "$2"
		elif [ $isFedora == "true" ]; then
			ear "$3"
		fi

		if ! [ -z "$4" ]; then
			ear "$4"
		fi

	else
		echo -e "$gre ✓ $1 is installed $off"
	fi

	spacer
}

spacer

TEMP=$HOME/dev/temp

MIRROR=http://mirrors/files.liferay.com/private/lrdcom

checkSoftware "pv" "sudo apt -y install pv" "sudo dnf -y install pv"

if [ -z "$1" ]; then
	FILE=www_lportal-$(date +"%Y-%m-%d")_19-00-PDT.sql.gz

	if curl -s --head  --request GET $MIRROR/$FILE | grep "200 OK" > /dev/null; then
		checkFile "$TEMP/$FILE" "curl -o $TEMP/$FILE -fSL $MIRROR/$FILE" "pv $TEMP/$FILE | gunzip | mysql -u root -p7777 liferay_db"
	else
		echo "$red $MIRROR/$FILE does not exist"
		echo " You can pass in a date as the first arg like: $off"
		echo "$blu 2018-03-21 $off"
		spacer
	fi

else
	FILE=www_lportal-$1_19-00-PDT.sql.gz

	if curl -s --head  --request GET $MIRROR/$FILE | grep "200 OK" > /dev/null; then
		checkFile "$TEMP/$FILE" "curl -o $TEMP/$FILE -fSL $MIRROR/$FILE" "pv $TEMP/$FILE | gunzip | mysql -u root -p7777 liferay_db"
	else
		echo "$red $MIRROR/$FILE does not exist $off"
		spacer
	fi
fi
