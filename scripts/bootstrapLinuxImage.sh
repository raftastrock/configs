#!/bin/bash
ear() { echo "\$ $@" ; "$@" ; }
spacer() { printf '\n-----------\n\n' ; }

isDebian=$(python -mplatform | grep -qi debian && echo true || echo false)
isFedora=$(python -mplatform | grep -qi fedora && echo true || echo false)

# Check for Git
if ! [ -x "$(command -v git)" ]; then
	echo 'Git is not installed'

	if [ $isDebian == 'true' ]; then
		ear sudo apt -y install git-all
	elif [ $isFedora == 'true' ]; then
		ear sudo dnf install git-all	
	fi

else
	echo '✓ Git is installed'
fi

spacer

# Check for curl
if ! [ -x "$(command -v curl)" ]; then
	echo 'curl is not installed'

	if [ $isDebian == 'true' ]; then
		ear sudo apt -y install curl
	elif [ $isFedora == 'true' ]; then
		ear sudo dnf -y install curl
	fi

else
	echo '✓ curl is installed'
fi

spacer

# Check for Nodejs
if ! [ -x "$(command -v node)" ]; then
	echo 'Nodejs is not installed'
	echo '===> Installing Node.js'

	if [ $isDebian == 'true' ]; then
		ear curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
		ear sudo apt -y install nodejs
	elif [ $isFedora == 'true' ]; then
		ear curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
		ear sudo dnf -y install nodejs	
	fi

else
	echo '✓ Nodejs is installed'
fi

spacer

# Check for Zsh
if ! [ -x "$(command -v zsh)" ]; then
	echo 'x Zsh is not installed'
	echo '===> Installing Zsh'

	if [ $isDebian == 'true' ]; then
		ear sudo apt -y install zsh
	elif [ $isFedora == 'true' ]; then
		ear sudo dnf -y install zsh
	fi

	sudo chsh -s $(which zsh)
else
	echo '✓ Zsh is installed'
fi

spacer

# Check for oh my zsh
if [ ! -d ~/.oh-my-zsh ] ; then
	echo 'x Oh My Zsh directory does not exist'
	echo '===> Installing Oh My Zsh'

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo '✓ Oh My Zsh directory exists'
fi

spacer

# Check for PS1
if [ ! -f ~/PS1.zsh ] ; then
	echo 'x PS1 file does not exist'
	echo '===> Downloading PS1 file'

	curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/PS1.zsh >> ~/PS1.zsh
else
	echo '✓ PS1 file exists'
fi

spacer

# Check for .zshrc
if [ ! -f ~/.zshrc ] ; then
	echo 'x .zshrc file does not exist'
	echo '===> Downloading .zshrc file'

	curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/.zshrc >> ~/.zshrc
else
	echo '✓ .zshrc file exists'
fi

spacer

# Check for zsh git plugin
if [ ! -f ~/.oh-my-zsh/plugins/git2/git.plugin.zsh ] ; then
	echo 'x Zsh git plugin file does not exist'
	echo '===> Downloading git.plugin.zsh file'

	mkdir ~/.oh-my-zsh/plugins/git2

	curl -fsSL https://raw.githubusercontent.com/protoEvangelion/notes/master/dotfiles/git.plugin.zsh >> ~/.oh-my-zsh/plugins/git2/git.plugin.zsh
else
	echo '✓ git.plugin.zsh file exists'
fi

spacer
