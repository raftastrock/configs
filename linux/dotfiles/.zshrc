# PATH
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=512m'
export API_URL='http://localhost:1337'
export PATH=$HOME/bin:/usr/local/bin:$PATH
export TEMP=$HOME/temp
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export ZSH=/home/ryan/.oh-my-zsh

# PLUGINS
plugins=(git zsh-output-highlighting)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES
alias b='echo -n $(git rev-parse --abbrev-ref HEAD) | copy'
alias bright='bash brightness.sh'
alias c='clear'
alias copy='xclip -sel clip'
alias lock='gnome-screensaver-command -l'
alias hi='systemctl hibernate -i'
alias my='mysql -u root'
alias notes='cd ~/dev/notes && code .'
alias re='source ~/.zshrc'
alias restart='shutdown -r now'
alias sass='sudo npm rebuild node-sass --force'
alias suspend='systemctl suspend -i'
alias up='xmod && python listenForUsb.py'
alias xmod='xmodmap ~/.Xmodmap'

# GITHUB USER VARIABLES
export Allen='allen-ziegenfus'
export Joan='joanhyokim'
export Luke='raftastrock'
export Phil='phillipchan2'
export Ryan='ryanschuhler'
export Weston='westonhancock'
export Proto='protoEvangelion'

export JoanIcon=':herb:'
export LukeIcon=':mount_fuji:'
export PhilIcon=':palm_tree:'
export RyanIcon=':registered:'
export WestonIcon=':four_leaf_clover:'

# GITHUB REPOS
export nil='next-in-line'

# ALIASES GLOBAL
alias -g g='~/.oh-my-zsh/plugins/git/git.plugin.zsh' 
alias -g z='~/.zshrc'

# GENERAL FUNCTIONS
function new {
	cd ~/dev/temp
	touch $1
	code $1
	cd -
}

function s {
	cat $1 | grep $2
}

function zpush {
	cd ~/dev/notes/linux/dotfiles
	cp ~/.oh-my-zsh/plugins/git/git.plugin.zsh .
	cp ~/.zshrc .
	gsave "$1"
	cd -
}

function zpull {
	cd ~/dev/notes/linux/dotfiles
	git pull origin master
	cp .zshrc ~
	cp git.plugin.zsh ~/.oh-my-zsh/plugins/git
	re
	cd -
}

function jira {
	opn https://issues.liferay.com/browse/$1 -- 'google-chrome'
}


# LIFERAY FUNCTIONS

# Add custom server properties file with correct paths in LIFERAY & PLUGINS repo
function addDir {
	cd /home/ryan/dev/life/ee-6.2.x/liferay-portal-ee
	touch app.server.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > app.server.ryan.properties
	cd /home/ryan/dev/life/liferay-plugins-ee
	touch build.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > build.ryan.properties
	cd -
}

function clean {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/
	rm -rfv work/Catalina/localhost/osb-community-theme
}

function cleanAll {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/
	rm -rfv work/Catalina/localhost/osb-community-theme
	rm -rfv webapps/osb-community-theme/css/.sass-cache
	rm -rfv temp
	rm -rfv logs
}

# Serve Liferay
function serve {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/bin
	./catalina.sh run | lch -c ~/logColors.conf
	cd -
}

# Deploy community theme
function theme {
	clean | lch -c ~/logColors.conf
	cd /home/ryan/dev/life/liferay-plugins-ee/themes/osb-community-theme
	ant deploy | lch -c ~/logColors.conf
	cd -
	cd -
}

# Go to Tomcat Dir
function tom {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62
}

function rungradle {
	# Rename settings.gradle temporarily
	if [ -e settings.gradle ]
		then
			mv settings.gradle settings.gradle.tmp
	fi
	# Run regular gradle commands
	local root_level=$(git rev-parse --show-toplevel 2>/dev/null)
	if [[ -n "$root_level" && -f "$root_level/gradlew" ]]; then
		root_level="$root_level/gradlew"
	else
		root_level=$(which gradle)
	fi
	"$root_level" $@
	if [ -e settings.gradle.tmp ]
		then
			mv settings.gradle.tmp settings.gradle
	fi
}

# JACK SEARCH FUNCTIONS
function jse {
	jack --stat "$1" --grep "$2" --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

function jsc {
	jack "$1" --grep "$2" --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}


# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete
