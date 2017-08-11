# PATH
export ANT_OPTS='-Xms2048m -Xmx4096m -XX:MaxPermSize=512m'
export TEMP=$HOME/temp
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/home/ryan/.oh-my-zsh

# PLUGINS
plugins=(git)
source $ZSH/oh-my-zsh.sh
source ~/PS1.zsh

# ALIASES
alias b='bash brightness.sh'
alias c='clear'
alias copy='xclip -sel clip'
alias re='. ~/.zshrc'
alias sass='sudo npm rebuild node-sass --force'
alias serve='cd ../bundles/tom*/bin && ./catalina.sh run'
alias suspend='systemctl suspend'

# ALIASES GLOBAL
alias -g g='~/.oh-my-zsh/plugins/git/git.plugin.zsh' 
alias -g z='~/.zshrc'

# GENERAL FUNCTIONS
function zpush {
  cd ~/dev/notes/linuxCLI/scripts
  cp ~/.oh-my-zsh/plugins/git/git.plugin.zsh .
  cp ~/.zshrc .
  gsave '$1'
  cd -
}

function zpull {
  cd ~/dev/notes/linuxCLI/scripts
  git pull origin master
  cp .zshrc ~
  cp git.plugin.zsh ~/.oh-my-zsh/plugins/git
  re
  cd -
}

# Jack functions
function jse {
  jack --stat '$1' --grep '$2' --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

function jsc {
  jack '$1' --grep '$2' --pretty=format:'%C(yellow)%h%Creset %C(white)%s - %an%Creset (%C(green)%ar%Creset)';
}

# GRADLE FUNCTION
function rungradle {

  # Rename settings.gradle temporarily
  if [ -e settings.gradle ]
    then
      mv settings.gradle settings.gradle.tmp
  fi

  # Run regular gradle commands
  local root_level=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ -n '$root_level' && -f '$root_level/gradlew' ]]; then
    root_level='$root_level/gradlew'
  else
    root_level=$(which gradle)
  fi

  '$root_level' $@

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

