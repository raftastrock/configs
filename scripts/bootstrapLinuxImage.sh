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

		echo -e "$blu ===> Building out $1 directory $off"

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

spacer

checkSoftware "git" "sudo apt -y install git-all" "sudo dnf install git-all"

checkSoftware "curl" "sudo apt -y install curl" "sudo dnf -y install curl"

checkSoftware "node" "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt -y install nodejs" "curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash - && sudo dnf -y install nodejs"

checkSoftware "zsh" "sudo apt -y install zsh" "sudo dnf -y install zsh" "sudo chsh -s $(which zsh)"

checkDir ~/.oh-my-zsh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

checkFile ~/PS1.zsh "curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/PS1.zsh >> ~/PS1.zsh"

checkFile ~/.zshrc "curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/.zshrc >> ~/.zshrc"

checkFile ~/.oh-my-zsh/plugins/git2/git.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/git2" "curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/git.plugin.zsh >> ~/.oh-my-zsh/plugins/git2/git.plugin.zsh"

checkFile ~/.oh-my-zsh/plugins/npm2/npm.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/npm2" "curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/npm.plugin.zsh >> ~/.oh-my-zsh/plugins/npm2/npm.plugin.zsh"
