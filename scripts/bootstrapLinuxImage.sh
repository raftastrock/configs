#!/bin/bash

# Text color variables
txtund=$(tput sgr 0 1)       # Underline
txtbld=$(tput bold)          # Bold
cyn=${txtbld}$(tput setaf 6) # cyan
red=${txtbld}$(tput setaf 1) # red
blu=${txtbld}$(tput setaf 4) # blue
gre=${txtbld}$(tput setaf 2) # green
wht=${txtbld}$(tput setaf 7) # white
ylw=$(tput setaf 3)					 # yellow
off=$(tput sgr0)             # Reset

ear() {
	echo -e "$cyn \$ $@ $off"
	eval "$@"
}

spacer() { echo -e "$ylw \n-----------\n $off" ; }

isDebian=$(python -mplatform | grep -qie debian -qie ubuntu && echo true || echo false)
isFedora=$(python -mplatform | grep -qi fedora && echo true || echo false)

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

checkDir() {
	if [ ! -d "$1" ]; then
		echo -e "$red x $1 directory does not exist $off"

		echo -e "$blu ===> Creating $1 directory $off"

		ear $2

	else
		echo -e "$gre ✓ $1 directory exists $off"
	fi

	spacer
}

checkFile() {
	if [ ! -f "$1" ]; then
		echo -e "$red x $1 file does not exist $off"

		echo -e "$blu ===> Downloading $1 file $off"

		ear $2

		if ! [ -z "$3" ]; then
			ear "$3"
		fi

	else
		echo -e "$gre ✓ $1 file exists $off"
	fi

	spacer
}

generateSsh() {
	if ! [ -f ~/.ssh/id_rsa.pub ]; then
		ssh-keygen -t rsa -b 4096 -C "ryantgarant@gmail.com" -f ~/.ssh/id_rsa -N ""

		curl -u "protoEvangelion" \
			--data "{\"title\":\"`date +%m/%d/%Y-%H:%M:%S`_$(python -mplatform)\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
			https://api.github.com/user/keys
	else
		echo -e "$gre ✓ ssh key exists $off"
	fi
}


spacer

checkSoftware "git" "sudo apt -y install git-all" "sudo dnf -y install git-all"

checkSoftware "node" "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt -y install nodejs" "curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash - && sudo dnf -y install nodejs"

checkSoftware "curl" "sudo apt -y install curl" "sudo dnf -y install curl"

checkSoftware "zsh" "sudo apt -y install zsh" "sudo dnf -y install zsh" "sudo chsh -s $(which zsh)"

generateSsh

checkDir ~/dev "mkdir ~/dev"

checkDir ~/dev/notes "git clone https://github.com/protoEvangelion/notes.git"

checkDir ~/.oh-my-zsh "sh -c ~/dev/notes/scripts/installOhMyZsh.sh"

checkFile ~/.Xmodmap "cp ~/dev/notes/dotfiles/.Xmodmap ~/" "xmodmap .Xmodmap"

checkFile ~/PS1.zsh "cp ~/dev/notes/dotfiles/PS1.zsh ~/"

checkFile ~/.zshrc "cp ~/dev/notes/dotfiles/.zshrc ~/" "source .zshrc"

checkFile ~/logColors.conf "cp ~/dev/notes/dotfiles/logColors.conf ~/"

checkFile ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/git2" "cp ~/dev/notes/dotfiles/git2.plugin.zsh ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh"

checkFile ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/npm2" "cp ~/dev/notes/dotfiles/npm2.plugin.zsh ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh"