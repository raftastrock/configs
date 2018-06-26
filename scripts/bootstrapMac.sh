#!/bin/bash

# Text color variables
txtund=$(tput sgr 0 1)       # Underline
txtbld=$(tput bold)          # Bold
cyn=${txtbld}$(tput setaf 6) # cyan
red=${txtbld}$(tput setaf 1) # red
blu=${txtbld}$(tput setaf 4) # blue
gre=${txtbld}$(tput setaf 2) # green
wht=${txtbld}$(tput setaf 7) # white
ylw=$(tput setaf 3)			 # yellow
off=$(tput sgr0)             # Reset

isMac=$(python -mplatform | grep -qie darwin && echo true || echo false)

configs=~/dev/configs

ear() {
	echo -e "$cyn \$ $@ $off"
	eval "$@"
}

spacer() { echo -e "$ylw \n-----------\n $off" ; }

checkSoftware() {
	if ! [ -x "$(command -v $1)" ]; then
		echo -e "$red $1 is not installed $off"

		echo -e "$blu ===> Installing $1 $off"

		if [ $isMac == "true" ]; then
			ear "$2"
		fi

		if ! [ -z "$3" ]; then
			ear "$3"
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

		echo -e "$blu ===> Copying $1 file $off"

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
		ssh-keygen -t rsa -b 4096 -C "ryantgarant@gmail.com" -f ~/.ssh/id_rsa

		curl -u "protoEvangelion" \
			--data "{\"title\":\"`date +%m/%d/%Y-%H:%M:%S`_$(python -mplatform)\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" \
			https://api.github.com/user/keys
	else
		echo -e "$gre ✓ ssh key exists $off"
	fi
}

spacer

checkDir ~/dev "mkdir ~/dev" "sudo chmod +w"

checkSoftware "brew" "/usr/bin/ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)'"

checkSoftware "git" "" "git --version"

if [ $(git config --global user.name) = "" ]; then
  echo "Make sure to set git user name & email \n git config --global user.name"
  spacer
fi

checkDir $configs "cd ~/dev && git clone git@github.com:protoEvangelion/configs.git"

checkSoftware "zsh" "brew install zsh" "brew install zsh-completions"

checkSoftware "ag" "brew install the_silver_searcher"

checkSoftware "curl" "brew install curl"

checkSoftware "docker" "brew install docker"

checkSoftware "exa" "brew install exa"

checkSoftware "nodebrew" "curl -L git.io/nodebrew | perl - setup && nodebrew install stable && nodebrew use stable"

checkSoftware "code" "brew cask install visual-studio-code"

checkSoftware "yarn" "brew install yarn"

# Check only if installed undered Brew

brew cask list amethyst || brew cask install amethyst
spacer
brew cask list firefox-developer-edition || brew cask install firefox-developer-edition
spacer
brew list grep || brew install grep --with-default-name
spacer
brew list zsh-completions || brew install zsh-completions

###

generateSsh

checkSoftware "keychain" "ruby -e '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)' < /dev/null 2> /dev/null" "brew install keychain"

checkDir ~/.oh-my-zsh "sh -c $configs/scripts/installOhMyZsh.sh"

checkFile ~/PS1.zsh "cp $configs/dotfiles/PS1.zsh ~/"

checkFile ~/.zshrc "cp $configs/dotfiles/.zshrc ~/" "source  ~/.zshrc"

checkFile ~/logColors.conf "cp $configs/dotfiles/logColors.conf ~/"

checkFile ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/git2" "cp $configs/dotfiles/git2.plugin.zsh ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh"

checkFile ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh "mkdir ~/.oh-my-zsh/plugins/npm2" "cp $configs/dotfiles/npm2.plugin.zsh ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh"

checkDir ~/.npm-global "mkdir ~/.npm-global && npm config set prefix '~/.npm-global'"

# Npm software
ng() {
	npm i -g $1
}

checkSoftware "checkit" "ng check-it-out"
checkSoftware "gh" "ng gh"
checkSoftware "git-br" "ng git-br"
checkSoftware "jack" "ng jack-cli"
checkSoftware "opn" "ng opn-cli"
checkSoftware "eslint" "ng eslint"