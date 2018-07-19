# PATH
APPS=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:/opt/firefox-dev
GENERAL=~/bin:~/.npm-global/bin:~/.local/share/umake/bin:~/dev/configs/scripts:~/.nodebrew/current/bin:/usr/local/Cellar/grep/3.1/bin/
JAVA_APPS=/opt/gradle/gradle-3.4.1/bin:/usr/local/opt/ant@1.9/bin
export PATH=$APPS:$GENERAL:$JAVA_APPS:$PATH

# VARIABLES
# export ANT_HOME=$HOME/apache-ant-1.9.13
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=10000m'
export API_URL='http://localhost:1337'
export GRADLE_HOME=/usr/local/gradle
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export JAVA_OPTS='-Xms1024m -Xmx8000m -XX:MaxPermSize=4000m'
export TEMP=$HOME/temp
export NODE_PATH=~/.npm-global/lib/node_modules
export ZSH=~/.oh-my-zsh

# MAC SPECIFIC SETS
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
CONFIG_DIR="$HOME/Library/Application Support/Code/User"

# SETUP SSH KEYCHAIN
/usr/local/bin/keychain --quiet $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh

# OhMyZsh PLUGINS
plugins=(
  colored-man-pages
  colorize
  docker
  docker-compose
  gpg-agent
  git2
)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES GLOBAL Files (treats as string for quick referencing/editing)
alias -g boots='~/dev/configs/scripts/bootstrapMac.sh'
alias -g g='~/.oh-my-zsh/plugins/git2/git2.plugin.zsh'
alias -g utils='~/dev/life/liferay-plugins-ee/themes/osb-community-theme/docroot/_diffs/css/_utilities.scss'
alias -g vars='~/dev/life/liferay-plugins-ee/themes/osb-community-theme/docroot/_diffs/css/_variables.scss'
alias -g z='~/.zshrc'
## Kararbiner is R2's favorite keyboard modifier (set to vim arrows?)
alias -g kar='~/.config/karabiner/karabiner.json'

# ALIASES
alias acd='ant clean deploy | lch -c ~/logColors.conf'
alias acdd='ant direct-deploy | lch -c ~/logColors.conf'
alias b='git rev-parse --abbrev-ref HEAD | copy'
alias c='clear'
alias copy="tr -d '\n' | pbcopy"
alias doc='docker-compose $@'
alias doce='docker-compose exec 62_liferay bash'
alias docl='docker-compose logs $@'
alias docr='docker-compose down && docker-compose up -d --build'
alias l='exa -la'
alias lc='lch -c ~/logColors.conf'
alias ls='exa'
alias j='jack' # Alias for jack-cli npm package
alias my='mysql -u root'
alias re='source ~/.zshrc'
alias sf='find . -name "*" | grep -v node_modules | xargs csf' # check source formatter

# GITHUB USER VARIABLES
export allen='allen-ziegenfus' # can be referenced with $allen
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

# GITHUB ORGS
export life='liferay'

# GITHUB BRANCHES
export e62='ee-6.2.x' # can use 'gco' (git check out) $e62 to checkout ee-6.2.x
export e61='ee-6.1.x'

# JIRA PROJECTS
export lrisa='LR Information Services' #default assignee
export lrisp='LRIS' #project
export lrist='IS Request' #type
export lrisc='Liferay.com' #component
# new ticket
function jiran {
  gh ji -N -A $lrisa -p $lrisp -T $lrist -C $lrisc --title $1 --message $2
}

# GENERAL UTILITY FUNCTIONS

## Set Java Version
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }

## Ways to remember what our standards are...
function fonts {
  echo "extra-light: 200 - .font-weight-lighter"
  echo "light:       300"
  echo "regular:     400"
  echo "semi-bold:   600 - .font-weight-bold"
  echo "bold:        700"
}

function media {
  echo "@media all and (max-width: 576px) {}"
  echo "@media all and (max-width: 767px) {}"
  echo "@media all and (max-width: 979px) {}"
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

# Install `tree` first — brew install tree
function t() {
  # Defaults to 3 levels deep, do more with `t 5` or `t 1`
  # pass additional args after
  tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 100 -L ${1:-3} -aC $2
}

function zpush {
  cd ~/dev/configs/dotfiles
  cp ~/.oh-my-zsh/plugins/git2/git2.plugin.zsh .
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
  cp settings.json $CONFIG_DIR/settings.json
  cp keybindings.json $CONFIG_DIR/keybindings.json
  cp global.code-snippets $CONFIG_DIR/snippets/global.code-snippets
  source ~/.zshrc
  cd -
}

# LIFERAY FUNCTIONS
LIFERAY_DIR=$HOME/dev/life
BUNDLES_DIR=$LIFERAY_DIR/bundles
DOCKER_DIR=$LIFERAY_DIR/docker/www-prod/liferay
PORTAL_DIR=$LIFERAY_DIR/liferay-portal-ee
PLUGINS_DIR=$LIFERAY_DIR/liferay-plugins-ee
PLUGINS_BUILD_FILE=build.$(whoami).properties

# 6.2
SERVER_62_BUNDLE=$BUNDLES_DIR/6.2
SERVER_62_DIR=$SERVER_62_BUNDLE/tomcat*

# 6.1
SERVER_61_BUNDLE=$BUNDLES_DIR/6.1
SERVER_61_DIR=$SERVER_61_BUNDLE/tomcat-7.0.40
THEME_61_DIR=~/dev/life/liferay-plugins-ee/themes/osb-community-theme

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
  touch app.server.$(whoami).properties
  echo "app.server.parent.dir=$BUNDLES_DIR" > app.server.$(whoami).properties
  cd -

  if [[ $1 ]]; then
    cd $HOME/dev/life/$1 || return 1
  else
    cd $PLUGINS_DIR || return 1
  fi

  touch build.luke.properties
  echo "app.server.parent.dir=$BUNDLES_DIR" > build.$(whoami).properties
  cd -
}

function clean61 {
	cd $SERVER_61_DIR || return 1
	rm -rfv work/Catalina/localhost/osb-community-theme
	rm -rfv webapps/osb-community-theme/css/.sass-cache
	cd -
	cd $THEME_61_DIR/docroot/css || return 1
	rm -rfv .sass-cache
	cd -
}

function cleanAll {
  cd $BUNDLES_DIR/tomcat*/bin || return 1
  rm -rfv work/Catalina/localhost/osb-community-theme
  rm -rfv webapps/osb-community-theme/css/.sass-cache
  rm -rfv temp
  rm -rfv logs
  cd -
}

# Serve Liferay
function serve {
  cd $BUNDLES_DIR/tomcat*/bin || return 1
  ./catalina.sh run | lch -c ~/logColors.conf
  cd -
}

# Serve Liferay
function serve7 {
  cd $HOME/dev/life/ee-7.0.x/bundles/tomcat*/bin || return 1
  ./catalina.sh run | lch -c ~/logColors.conf
  cd -
}

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete