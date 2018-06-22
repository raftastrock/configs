# PATH
APPS=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:/opt/firefox-dev
GENERAL=HOME/bin:~/.npm-global/bin:~/.local/share/umake/bin:~/dev/configs/scripts:~/.nodebrew/current/bin
JAVA_APPS=/opt/gradle/gradle-3.4.1/bin:~/apache-ant-1.9.11/bin
export PATH=$APPS:$GENERAL:$JAVA_APPS:$PATH

# VARIABLES
export ANT_HOME=$HOME/apache-ant-1.9.11
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=10000m'
export API_URL='http://localhost:1337'
export GRADLE_HOME=/usr/local/gradle
export JAVA_OPTS='-Xms1024m -Xmx8000m -XX:MaxPermSize=4000m'
export TEMP=$HOME/temp
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export NODE_PATH=~/.npm-global/lib/node_modules
export ZSH=~/.oh-my-zsh
export IS_MAC=$(python -mplatform | grep -qie darwin && echo true || echo false)

if [[ $IS_MAC = true ]]; then
  unset LSCOLORS
  export CLICOLOR=1
  export CLICOLOR_FORCE=1
  export JAVA_HOME=$(/usr/libexec/java_home)
  CONFIG_DIR="$HOME/Library/Application Support/Code/User"
  echo "ismac!"
else
  CONFIG_DIR="$HOME/.config/Code/User"
  alias code='vscode'
  echo "not mac!"
fi

# SETUP SSH KEYCHAIN
/usr/local/bin/keychain --quiet $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh

# PLUGINS
plugins=(colorize git2 npm2)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES GLOBAL Files
alias -g g='~/.oh-my-zsh/plugins/git2/git2.plugin.zsh'
alias -g nplug='~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh'
alias -g utils='~/dev/life/liferay-plugins-ee/themes/osb-community-theme/docroot/_diffs/css/_utilities.scss'
alias -g vars='~/dev/life/liferay-plugins-ee/themes/osb-community-theme/docroot/_diffs/css/_variables.scss'
alias -g z='~/.zshrc'
alias -g kar='~/.config/karabiner/karabiner.json'

# ALIASES
alias add='bash addComponent.sh'
alias acd='lc ant clean deploy'
alias b='git rev-parse --abbrev-ref HEAD'
alias bright='bash brightness.sh'
alias c='clear'
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
alias ls='ls'
alias hi='systemctl hibernate -i'
alias j='jack' # Alias for jack-cli npm package
alias my='mysql -u root'
alias configs='cd ~/dev/configs && code .'
alias re='source ~/.zshrc'
alias restart='shutdown -r now'
alias sai='sudo apt install $@'
alias sas='sudo apt search $1'
alias sass='npm rebuild node-sass --force'
alias sar='sudo apt remove $@'
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

# GENERAL UTILITY FUNCTIONS

function fonts {
  echo "extra-light: 200 - .font-weight-lighter"
  echo "light:       300"
  echo "regular:     400"
  echo "semi-bold:   600 - .font-weight-bold"
  echo "bold:        700"
}

function media {
  echo "@media all and (max-width: 576px) {}"
  echo "@media all and (max-width: 768px) {}"
  echo "@media all and (max-width: 980px) {}"
}

# Command to download recored-gif script: curl -l https://git.io/record-gif.sh | bash -
function gif {
  record-gif.sh $1 ~/Videos/$2.gif
}

# do math
function m {
  node -pe $@
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

function sb {
  regex='.*(?s)(?<='$2').*?(?=})'
  cat $1 | grep -Pzo $regex
}

function slang {
  printf "\n===============================\n\n"

  echo "Showing language keys in:  ~/dev/life/web-dev-lrdcom/6.2.x/templates/global/language_keys.ftl"

  printf "\n===============================\n\n"

  cat ~/dev/life/web-dev-lrdcom/6.2.x/templates/global/language_keys.ftl | grep -E --color $1

  echo "Showing language keys in:  ~/dev/life/liferay-portal-ee/portal-impl/src/content/Language.properties"

  printf "\n===============================\n\n"

  cat ~/dev/life/liferay-portal-ee/portal-impl/src/content/Language.properties | grep -E --color $1
}

function zpush {
  cd ~/dev/configs/dotfiles
  cp ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh .
  cp ~/.oh-my-zsh/plugins/npm2/npm2.plugin.zsh .
  cp $CONFIG_DIR/settings.json .
  cp $CONFIG_DIR/keybindings.json .
  cp $CONFIG_DIR/snippets/global.code-snippets .
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
  cp settings.json $CONFIG_DIR/settings.json
  cp keybindings.json $CONFIG_DIR/keybindings.json
  cp global.code-snippets $CONFIG_DIR/snippets/global.code-snippets
  source ~/.zshrc
  cd -
}

# LIFERAY FUNCTIONS
LIFERAY_DIR=$HOME/dev/life
BUNDLES_DIR=$LIFERAY_DIR/bundles
DOCKER_DIR=$LIFERAY_DIR/liferay-is-marketing-wedeploy/www-prod/liferay
PORTAL_DIR=$LIFERAY_DIR/liferay-portal-ee
PLUGINS_DIR=$LIFERAY_DIR/liferay-plugins-ee
PLUGINS_BUILD_FILE=build.$(whoami).properties

# 6.2
SERVER_62_BUNDLE=$BUNDLES_DIR/6.2
SERVER_62_DIR=$SERVER_62_BUNDLE/tomcat-7.0.62

# 6.1
SERVER_61_BUNDLE=$BUNDLES_DIR/6.1
SERVER_61_DIR=$SERVER_61_BUNDLE/tomcat-7.0.40

# Add custom server properties file with correct paths in LIFERAY & PLUGINS repo
function dockerDir {
  cd $PLUGINS_DIR || return 1
  echo "" > $PLUGINS_BUILD_FILE
  echo docker.dir=$DOCKER_DIR >> $PLUGINS_BUILD_FILE
  echo bundle.dir=$SERVER_62_BUNDLE >> $PLUGINS_BUILD_FILE
  echo app.server.parent.dir=$DOCKER_DIR >> $PLUGINS_BUILD_FILE
  echo app.server.tomcat.dir=$DOCKER_DIR/tomcat >> $PLUGINS_BUILD_FILE
  echo app.server.tomcat.deploy.dir=$DOCKER_DIR/tomcat/webapps >> $PLUGINS_BUILD_FILE
  echo app.server.tomcat.lib.global.dir=$SERVER_62_DIR/lib/ext >> $PLUGINS_BUILD_FILE
  echo app.server.tomcat.portal.dir=$SERVER_62_DIR/webapps/ROOT >> $PLUGINS_BUILD_FILE
  cd -
}

function 61Dir {
  cd $PORTAL_DIR || return 1
  echo app.server.parent.dir=$SERVER_61_BUNDLE > app.server.$(whoami).properties
  cd -
  cd $PLUGINS_DIR || return 1
  echo app.server.parent.dir=$SERVER_61_BUNDLE > $PLUGINS_BUILD_FILE
  cd -
}

function addDir {
  cd $PORTAL_DIR || return 1
  touch app.server.ryan.properties
  echo "app.server.parent.dir=$BUNDLES_DIR" > app.server.ryan.properties
  cd -

  if [[ $1 ]]; then
    cd $HOME/dev/life/$1 || return 1
  else
    cd $PLUGINS_DIR || return 1
  fi

  touch build.ryan.properties
  echo "app.server.parent.dir=$BUNDLES_DIR" > build.ryan.properties
  cd -
}

function clean {
  cd $BUNDLES_DIR/tomcat-7.0.62/ || return 1
  rm -rfv work/Catalina/localhost/osb-community-theme
}

function cleanAll {
  cd $BUNDLES_DIR/tomcat-7.0.62/bin || return 1
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
  cd $BUNDLES_DIR/tomcat-7.0.62/bin || return 1
  ./catalina.sh run | lch -c ~/logColors.conf
  cd -
}

# Serve Liferay
function serve7 {
  cd $HOME/dev/life/ee-7.0.x/bundles/tomcat-8.0.32/bin || return 1
  ./catalina.sh run | lch -c ~/logColors.conf
  cd -
}

# Deploy community theme
function theme {
  clean
  cd $HOME/dev/life/liferay-plugins-ee/themes/osb-community-theme || return 1
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
