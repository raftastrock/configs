#!/bin/bash
ear() { echo "\$ $@" ; "$@" ; }
spacer() { printf '\n-----------\n\n' ; }

platform=$(python -mplatform)

UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi

spacer

echo "$platform"
echo "$DISTRO"

spacer

# Check for Git
if ! [ -x "$(command -v git)" ]; then
	echo '❌ Git is not installed'

	ear sudo apt-get install git-all

	ear sudo dnf install git-all
else
	echo '✓ Git is installed'
fi

spacer

# Check for Nodejs
if ! [ -x "$(command -v node)" ]; then
	echo '❌ Nodejs is not installed'
	echo '===> Installing Node.js'

	ear curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	ear sudo apt install -y nodejs

	ear curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
	ear sudo dnf -y install nodejs

else
	echo '✓ Nodejs is installed'
fi

spacer

# Check for VS Code
if ! [ -x "$(command -v code)" ]; then
	echo '❌ VS Code is not installed'
	echo '===> Installing VS Code'

	ear wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
	ear sudo dpkg -i /tmp/code_latest_amd64.deb

else
	echo '✓ VS Code is installed'
fi

spacer

# Check for Zsh
if ! [ -x "$(command -v zsh)" ]; then
	echo '❌ Zsh is not installed'
	echo '===> Installing Zsh'

	ear sudo apt install zsh

	ear sudo dnf install zsh


else
	echo '✓ Zsh is installed'
fi

spacer

# Check for oh my zsh
if [ -d "~/.oh-my-zsh" ]; then
	echo '❌ Oh My Zsh directory does not exist'
	echo '===> Installing Oh My Zsh'

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	echo '✓ Oh My Zsh directory exists'
fi

spacer
