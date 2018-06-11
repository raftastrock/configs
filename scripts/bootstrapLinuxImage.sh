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

isDebian=$(python -mplatform | grep -qie debian -qie ubuntu && echo true || echo false)
isFedora=$(python -mplatform | grep -qi fedora && echo true || echo false)
isMac=$(python -mplatform | grep -qie darwin && echo true || echo false)
isUbuntu=$(python -mplatform | grep -qie ubuntu && echo true || echo false)

configs=~/dev/configs

idnf() {
	sudo dnf install -y "$@"
}

iapt() {
	sudo apt install -y "$@"
}

ear() {
	echo -e "$cyn \$ $@ $off"
	eval "$@"
}

spacer() { echo -e "$ylw \n-----------\n $off" ; }

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

checkUbuntuSoftware() {
	if [ $isUbuntu == "true" ]; then
		if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
			echo -e "$red $1 is not installed $off"

			echo -e "$blu ===> Installing $1 $off"

			ear $2
		else
			echo -e "$gre ✓ $1 is installed $off"
		fi
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

vsCodeDebian() {
	sudo snap install vscode --classic
	rm ~/.config/Code/User/settings.json
	cp $configs/dotfiles/settings.json ~/.config/Code/User/settings.json
	cd ~/dev/configs/dotfiles/
	./extenstions
	cd
	git config --global core.editor "code --wait"
}

vsCodeFedora() {
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	sudo dnf -y check-update
	idnf code
	rm ~/.config/Code/User/settings.json
	cp $configs/dotfiles/settings.json ~/.config/Code/User/settings.json
}

checkDir ~/dev "mkdir ~/dev" "sudo chmod a+w"

checkSoftware "git" "iapt git" "idnf git"

checkDir $configs "cd ~/dev && git clone git@github.com:protoEvangelion/configs.git"

checkSoftware "zsh" "iapt zsh" "idnf zsh" "rm ~.zshrc"

checkSoftware "ag" "iapt silversearcher-ag" "idnf the_silver_searcher"

checkSoftware "curl" "iapt curl" "idnf curl"

checkSoftware "docker" "iapt docker.io && sudo systemctl start docker && sudo systemctl enable docker"

checkSoftware "java" "iapt default-jdk" "idnf java-1.8.0-openjdk"

checkSoftware "node" "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - &&  iapt nodejs" "curl -sL https://rpm.nodesource.com/setup_8.x | sudo bash - && idnf nodejs"

checkSoftware "snap" "iapt snapd" "idnf snapd"

checkSoftware "code" "vsCodeDebian" "vsCodeFedora"

checkSoftware "yarn" "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo \"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list && sudo apt update && sudo apt -y install yarn" "curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo && sudo dnf -y install yarn"

checkSoftware "xclip" "iapt xclip" "idnf xclip"

checkUbuntuSoftware "gnome-tweak-tool" "iapt gnome-tweak-tool"

checkUbuntuSoftware "umake" "sudo add-apt-repository ppa:lyzardking/ubuntu-make -y && iapt ubuntu-make"

checkSoftware "firefox-developer" "umake web firefox-dev"

generateSsh

checkSoftware "keychain" "iapt keychain" "idnf keychain"

checkDir ~/dev/quicktile "cd ~/dev && git clone https://github.com/ssokolow/quicktile"

checkSoftware "quicktile" "iapt python-gtk2 python-xlib python-dbus python-wnck python-setuptools" "idnf pygtk2 pygobject2 dbus-python gnome-python2-libwnck" "cd ~/dev/quicktile && ./install.sh  && quicktile"

checkDir ~/.oh-my-zsh "sh -c $configs/scripts/installOhMyZsh.sh"

checkFile ~/.Xmodmap "cp $configs/dotfiles/.Xmodmap ~/" "xmodmap .Xmodmap"

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

checkSoftware "checkit" "ng check-it-out" "ng check-it-out"
checkSoftware "gh" "ng gh" "ng gh"
checkSoftware "git-br" "ng git-br" "ng git-br"
checkSoftware "jack" "ng jack-cli" "ng jack-cli"
checkSoftware "opn" "ng opn-cli" "ng opn-cli"
checkSoftware "eslint" "ng eslint" "ng eslint"