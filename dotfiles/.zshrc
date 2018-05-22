# PATH
export PATH=/usr/local/bin:$HOME/bin:~/.npm-global/bin:~/.local/share/umake/bin:~/dev/configs/scripts:~/jpm/bin:$GRADLE_HOME/bin:/opt/firefox-dev:$PATH

# VARIABLES
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=10000m'
export API_URL='http://localhost:1337'
export GRADLE_HOME=/usr/local/gradle
export JAVA_OPTS='-Xms1024m -Xmx8000m -XX:MaxPermSize=4000m'
export TEMP=$HOME/temp
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export NODE_PATH=~/.npm-global/lib/node_modules
export ZSH=~/.oh-my-zsh

# SETUP SSH KEYCHAIN
/usr/bin/keychain --quiet $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh

# PLUGINS
plugins=(colorize git2 npm2)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES GLOBAL
alias -g g='~/.oh-my-zsh/plugins/git2/git2.plugin.zsh'
alias -g np='~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh'
alias -g z='~/.zshrc'

# ALIASES
alias add='bash addComponent.sh'
alias acd='lc ant clean deploy'
alias b='git rev-parse --abbrev-ref HEAD'
alias bright='bash brightness.sh'
alias c='clear'
alias code='vscode'
alias copy='xclip -sel clip'
alias doc='docker-compose $@'
alias doce='docker-compose exec 62_liferay bash'
alias docl='docker-compose logs $@'
alias docr='docker-compose down && docker-compose up -d --build'
alias firefox='firefox-developer'
alias getip='ip route get 8.8.8.8 | awk "{print $NF; exit}"'
alias gd='gulp deploy'
alias lock='gnome-screensaver-command -l'
alias lc='bash logColors.sh'
alias ls='ls -F --color=auto'
alias hi='systemctl hibernate -i'
alias j='jack' # Alias for jack-cli npm package
alias my='mysql -u root'
alias configs='cd ~/dev/configs && code .'
alias re='source ~/.zshrc'
alias restart='shutdown -r now'
alias sai='sudo apt install $@'
alias sas='sudo apt search $1'
alias sass='npm rebuild node-sass --force'
alias sf='find . -name "*" | grep -v node_modules | xargs csf'
alias suspend='systemctl suspend -i'
alias switchJava='sudo update-alternatives --config java'
alias up='xmod && python listenForUsb.py'
alias x='xmodmap ~/.Xmodmap'
alias x2='xmodmap ~/.Xmodmap2'

# GITHUB USER VARIABLES
export allen='allen-ziegenfus'
export bchan='brianchandotcom'
export design='liferay-design'
export joan='joanhyokim'
export johanna='jotchon'
export josh='jwu910'
export justin='justinsunho'
export luke='raftastrock'
export paul='plhnk'
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

# MONITOR FUNCTIONS
function homeScreen {
	xrandr --output VGA-1 --auto
	xrandr --output HDMI-1 --auto
	xrandr --output VGA-1 --left-of HDMI-1
	xrandr --output HDMI-1 --primary
}

function ws {
	xrandr --output HDMI-1 --auto
	xrandr --output HDMI-1 --primary
	xrandr --output eDP-1 --auto
	xrandr --output eDP-1 --mode 2048x1152
	xrandr --output HDMI-1 --left-of eDP-1
}

function ws2 {
	xrandr --output eDP-1
	xrandr --output HDMI2 --primary
	xrandr --output eDP-1 --below HDMI2
}

function ws3 {
	xrandr --output eDP-1 --auto
	xrandr --output eDP-1 --primary
	xrandr --output eDP-1 --mode 2048x1152
	xmodmap .Xmodmap2
}


function singleScreen {
	xrandr --output eDP1 --auto
}

# Command to download recored-gif script: curl -l https://git.io/record-gif.sh | bash -
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

function slang {
	printf "\n===============================\n\n"

	echo "Showing language keys in:  ~/dev/web-dev-lrdcom/6.2.x/templates/global/language_keys.ftl"

	printf "\n===============================\n\n"

	cat ~/dev/web-dev-lrdcom/6.2.x/templates/global/language_keys.ftl | grep -E --color $1

	echo "Showing language keys in:  ~/dev/life/ee-6.2.x/liferay-portal-ee/portal-impl/src/content/Language.properties"

	printf "\n===============================\n\n"

	cat ~/dev/life/ee-6.2.x/liferay-portal-ee/portal-impl/src/content/Language.properties | grep -E --color $1
}

function zpush {
	cd ~/dev/configs/dotfiles
	cp ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh .
	cp ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh .
	cp ~/.config/Code/User/settings.json .
	cp ~/.config/Code/User/keybindings.json .
	cp ~/.config/Code/User/snippets/global.code-snippets .
	cp ~/.zshrc .
	gsave "$1"
	cd -
}

function zpull {
	cd ~/dev/configs/dotfiles || return 1
	git fetch origin
	git reset --hard origin/master
	gcleandry
	cp .zshrc ~
	cp git2.plugin.zsh ~/.oh-my-zsh/plugins/git2
	cp npm2.plugin.zsh ~/.oh-my-zsh/plugins/npm2
	cp settings.json ~/.config/Code/User/settings.json
	cp keybindings.json ~/.config/Code/User/keybindings.json
	cp global.code-snippets ~/.config/Code/User/snippets/global.code-snippets
	source ~/.zshrc
	cd -
}

# LIFERAY FUNCTIONS

# Add custom server properties file with correct paths in LIFERAY & PLUGINS repo
function addBuild {
	cd ../../
	touch build.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > build.ryan.properties
	cd -
}

function addDir {
	cd /home/ryan/dev/life/ee-6.2.x/liferay-portal-ee || return 1
	touch app.server.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > app.server.ryan.properties
	cd -

	if [[ $1 ]]; then
		cd /home/ryan/dev/life/$1 || return 1
	else
		cd /home/ryan/dev/life/liferay-plugins-ee || return 1
	fi

	touch build.ryan.properties
	echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > build.ryan.properties
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

# JACK SEARCH FUNCTIONS
function jse {
	jack --stat $1 --grep $2 --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

function jsc {
	jack $1 --grep $2 --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete
