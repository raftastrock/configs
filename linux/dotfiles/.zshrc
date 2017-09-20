# PATH
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=512m'
export TEMP=$HOME/temp
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/home/ryan/.oh-my-zsh
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# PLUGINS
plugins=(git zsh-output-highlighting)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES
alias b='bash brightness.sh'
alias c='clear'
alias copy='xclip -sel clip'
alias lock='gnome-screensaver-command -l'
alias hi='systemctl hibernate'
alias my='mysql -u root'
alias notes='cd ~/dev/notes && code .'
alias re='source ~/.zshrc'
alias restart='shutdown -r now'
alias sass='sudo npm rebuild node-sass --force'
alias suspend='systemctl suspend -i'
alias xmod='xmodmap ~/.Xmodmap'

# Github User Variabls
export Allen='allen-ziegenfus'
export Joan='joanhyokim'
export Luke='raftastrock'
export Phil='phillipchan2'
export Ryan='ryanschuhler'
export Weston='westonhancock'
export Proto='protoEvangelion'

export RyanIcon=':registered:'
export LukeIcon=':floppy_disk:'

# ALIASES GLOBAL
alias -g g='~/.oh-my-zsh/plugins/git/git.plugin.zsh' 
alias -g z='~/.zshrc'

# GENERAL FUNCTIONS
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

# Jack functions
function jse {
  jack --stat "$1" --grep "$2" --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

function jsc {
  jack "$1" --grep "$2" --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}


# LIFERAY FUNCTIONS

# Deploy community theme
function deploy-theme {
  cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/
  rm -rfv work/Catalina/localhost/osb-community-theme
  #rm -rfv webapps/osb-community-theme/css/.sass-cache
  #rm -rfv temp
  #rm -rfv logs
  cd /home/ryan/dev/life/liferay-plugins-ee/themes/osb-community-theme
  ant deploy
  cd -
  cd -
}

# Serve Liferay
function serve {
  cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62/bin
  ./catalina.sh run
  cd -
}

# Go to Tomcat Dir
function tom {
  cd /home/ryan/dev/life/ee-6.2.x/bundles/tomcat-7.0.62
}

# change main dir server directory
function mainDir {
  touch app.server.ryan.properties
  echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > app.server.ryan.properties
}

# change plugin dir server directory
function plugDir {
  touch build.ryan.properties
  echo "app.server.parent.dir=/home/ryan/dev/life/ee-6.2.x/bundles" > build.ryan.properties
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



################################################################################



# User configuration

# export MANPATH='/usr/local/man:$MANPATH'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS='-arch x86_64'

# ssh
# export SSH_KEY_PATH='~/.ssh/rsa_id'


# Set name of the theme to load. Optionally, if you set this to 'random'
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME='agnoster'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE='true'

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE='true'

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE='true'

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS='true'

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE='true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION='true'

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS='true'

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY='true'

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: 'mm/dd/yyyy'|'dd.mm.yyyy'|'yyyy-mm-dd'
# HIST_STAMPS='mm/dd/yyyy'

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Adding autocomplete for 'we'
[ -f ~/.we_autocomplete ] && source ~/.we_autocomplete
