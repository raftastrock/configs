# PATH
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=10000m'
export JAVA_OPTS='-Xms1024m -Xmx8000m -XX:MaxPermSize=4000m'
export API_URL='http://localhost:1337'
export GRADLE_HOME=/usr/local/gradle
export PATH=$HOME/bin:~/.npm-global/bin:~/jpm/bin:/usr/local/bin:$GRADLE_HOME/bin:$PATH
export TEMP=$HOME/temp
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export ZSH=/home/ryan/.oh-my-zsh

# PLUGINS
plugins=(git npm zsh-output-highlighting)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh
. /usr/share/autojump/autojump.sh

# ALIASES GLOBAL
alias -g g='~/.oh-my-zsh/plugins/git/git.plugin.zsh'
alias -g np='~/.oh-my-zsh/plugins/npm/npm.plugin.zsh'
alias -g z='~/.zshrc'

# ALIASES
alias add='bash addComponent.sh'
alias b='echo -n $(git rev-parse --abbrev-ref HEAD) | copy'
alias bright='bash brightness.sh'
alias c='clear'
alias copy='xclip -sel clip'
alias gd='gulp deploy'
alias lock='gnome-screensaver-command -l'
alias lc='bash logColors.sh'
alias ls='ls -F --color=auto'
alias hi='systemctl hibernate -i'
alias my='mysql -u root'
alias notes='cd ~/dev/notes && code .'
alias re='source ~/.zshrc'
alias restart='shutdown -r now'
alias sai='sudo apt install $1'
alias sas='sudo apt search $1'
alias sass='npm rebuild node-sass --force'
alias sf='find . -name "*" | xargs csf'
alias suspend='systemctl suspend -i'
alias up='xmod && python listenForUsb.py'
alias xmod='xmodmap ~/.Xmodmap'
alias xmod2='xmodmap ~/.Xmodmap2'

# GITHUB USER VARIABLES
export allen='allen-ziegenfus'
export bchan='brianchandotcom'
export design='liferay-design'
export joan='joanhyokim'
export josh='jwu910'
export luke='raftastrock'
export phil='phillipchan2'
export proto='protoEvangelion'
export ryan='ryanschuhler'
export weston='westonhancock'

export joanicon=':fist:'
export lukeicon=':mount_fuji:'
export philicon=':palm_tree:'
export ryanicon=':registered:'
export westonicon=':four_leaf_clover:'

# GITHUB ORGS
export cov='covailnt'
export gh='node-gh'
export life='liferay'
export nil='next-in-line'

# GITHUB BRANCHES
export e6='ee-6.2.x'

# JIRA PROJECTS
export lrisa='LR Information Services' #default assignee
export lrisp='LRIS' #project
export lrist='IS Request' #type
export lrisc='Liferay.com' #component
# new ticket
function jiran {
	gh ji -N -A $lrisa -p $lrisp -T $lrist -C $lrisc --title $1 --message $2
}

# GENERAL FUNCTIONS

function codeLatest {
	wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
	sudo dpkg -i /tmp/code_latest_amd64.deb
}

function codeVersion {
	wget https://vscode-update.azurewebsites.net/$1/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
	sudo dpkg -i /tmp/code_latest_amd64.deb
}

function screen {
	xrandr --output VGA-1 --left-of HDMI-1
	xrandr --output VGA-1 --primary
}

# Command to download recored-gif script: curl --location https://git.io/record-gif.sh | bash -
function gif {
	record-gif.sh $1 ~/Videos/$2.gif
}

function new {
	cd ~/dev/temp || return 1
	touch $1
	code $1
	cd -
}

function s {
	cat $1 | grep $2
}

function zpush {
	cd ~/dev/notes/dotfiles &&
	cp ~/.oh-my-zsh/plugins/git/git.plugin.zsh . &&
	cp ~/.oh-my-zsh/plugins/npm/npm.plugin.zsh . &&
	cp ~/.zshrc . &&
	gsave "$1"
	cd -
}

function zpull {
	cd ~/dev/notes/dotfiles || return 1
	git fetch origin
	git reset --hard origin/master
	gcleandry
	cp .zshrc ~
	cp git.plugin.zsh ~/.oh-my-zsh/plugins/git
	cp npm.plugin.zsh ~/.oh-my-zsh/plugins/npm
	re
	cd -
}

# LIFERAY FUNCTIONS

# Add custom server properties file with correct paths in LIFERAY & PLUGINS repo
function addDir {
	cd /home/ryan/dev/life/ee-6.2.x/liferay-portal-ee || return 1
	touch app.server.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > app.server.ryan.properties
	cd /home/ryan/dev/life/liferay-plugins-ee || return 1
	touch build.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > build.ryan.properties
	cd -
	cd -
}

function addDir1 {
	cd /home/ryan/dev/life/ee-6.1.x/liferay-portal-ee || return 1
	touch app.server.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.1.x/bundles" > app.server.ryan.properties
	cd /home/ryan/dev/life/liferay-plugins-ee || return 1
	touch build.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.1.x/bundles" > build.ryan.properties
	cd -
	cd -
}

function clean {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/ || return 1
	rm -rfv work/Catalina/localhost/osb-community-theme
}

function cleanAll {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/ || return 1
	rm -rfv work/Catalina/localhost/osb-community-theme
	rm -rfv webapps/osb-community-theme/css/.sass-cache
	rm -rfv temp
	rm -rfv logs
	cd -
}

function gw {
	gradle $1 | lch -c ~/logColors.conf
}

# Serve Liferay
function serve {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/bin || return 1
	./catalina.sh run | lch -c ~/logColors.conf
	cd -
}

# Serve Liferay
function serve7 {
	cd /home/ryan/dev/life/ee-7.0.x/bundles/tomcat-8.0.32/bin || return 1
	./catalina.sh run | lch -c ~/logColors.conf
	cd -
}

# Deploy community theme
function theme {
	clean
	cd /home/ryan/dev/life/liferay-plugins-ee/themes/osb-community-theme || return 1
	ant deploy | lch -c ~/logColors.conf
}

# Go to Tomcat Dir
function tom {
	cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62 || return 1
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
	jack --stat $1 --grep $2 --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

function jsc {
	jack $1 --grep $2 --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

# Mongo Mlab Backup
function mlabBackup {
	mongodump -h ds249575.mlab.com:49575 -d heroku_n9739n51 -c laBooths -u heroku_n9739n51 -p $1 -o /home/ryan/dev/interactiveTradeFloor/backup/la
	mongodump -h ds249575.mlab.com:49575 -d heroku_n9739n51 -c lbBooths -u heroku_n9739n51 -p $1 -o /home/ryan/dev/interactiveTradeFloor/backup/lb
}

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete

# This loads nvm bash_completion
