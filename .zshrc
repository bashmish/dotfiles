export DOTFILES=$HOME/.dotfiles

################################################################################
# zsh                                                                          #
################################################################################

export ZSH="$HOME/.oh-my-zsh"

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  ZSH_THEME="jtriley"
  plugins=(git)
  source $ZSH/oh-my-zsh.sh
fi

################################################################################
# node                                                                         #
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

backup_pm_rc () {
  mv_if_exists ~/.bowerrc ~/_bowerrc
  mv_if_exists ~/.npmrc ~/_npmrc
  mv_if_exists ~/.yarnrc ~/_yarnrc
}

unbackup_pm_rc () {
  mv_if_exists ~/_bowerrc ~/.bowerrc
  mv_if_exists ~/_npmrc ~/.npmrc
  mv_if_exists ~/_yarnrc ~/.yarnrc
}

reinstall_node_selenium () {
  rm -rf ./node_modules/selenium-standalone/.selenium
  ./node_modules/selenium-standalone/bin/selenium-standalone install
}

################################################################################
# cd                                                                           #
################################################################################

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cdp="cd ~/Files/Projects/"
else
  alias cdp="cd /media/sf_Projects/"
fi

################################################################################
# git                                                                          #
################################################################################

alias stree='/Applications/SourceTree.app/Contents/Resources/stree'
alias smerge='/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge'

git_config_personal () {
  git config user.name "Mikhail Bashkirov"
  git config user.email "bashmish@gmail.com"
}

# reword that keeps date/author/... untouched
# Usage for last commit:
#   git_reword "Omg typo in my last commit!!!"
# Usage for any commit:
#   git_reword "Omg I made a typo two days ago, how come!" 33168722e37ffffb7a285464c1fd9966925b7435
git_reword () {
  if [ -z "$2" ]; then
    local git_commit=$(git rev-parse HEAD)
  else
    local git_commit=$2
  fi
  git filter-branch -f --msg-filter \
  "if test \$GIT_COMMIT = '$git_commit'
  then
      echo '$1'; else cat
  fi"
}

################################################################################
# java                                                                         #
################################################################################

if /usr/libexec/java_home -v 1.8 &> /dev/null; then
  export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
  export PATH=$JAVA_HOME/bin:$PATH

  export M2_HOME=`mvn -v | grep 'Maven home' | sed 's/Maven home: //'`
  export PATH=$M2_HOME/bin:$PATH
  export MAVEN_OPTS="-Xms1024m -Xmx1024m"
fi

################################################################################
# caddy                                                                        #
################################################################################

alias caddy="/usr/local/bin/caddy -conf $DOTFILES/Caddyfile_frontend_app"

################################################################################
# proxy                                                                        #
################################################################################

proxy_on () {
  unbackup_pm_rc
  proxy_env_vars_on
  proxy_wifi_on
  proxy_ethernet_on
}

proxy_off () {
  backup_pm_rc
  proxy_env_vars_off
  proxy_wifi_off
  proxy_ethernet_off
}

proxy_env_vars_on () {
  export http_proxy="localhost:3128"
  export https_proxy="localhost:3128"
  export ftp_proxy="localhost:3128"
  export rsync_proxy="localhost:3128"
  export ssh_proxy="localhost:3128"
}

proxy_env_vars_off () {
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset rsync_proxy
  unset ssh_proxy
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  proxy_wifi_on () {
    sudo networksetup -setwebproxystate "Wi-Fi" on
    sudo networksetup -setsecurewebproxystate "Wi-Fi" on
  }

  proxy_wifi_off () {
    sudo networksetup -setwebproxystate "Wi-Fi" off
    sudo networksetup -setsecurewebproxystate "Wi-Fi" off
  }

  proxy_ethernet_on () {
    sudo networksetup -setwebproxystate "USB 10/100/1000 LAN" on
    sudo networksetup -setsecurewebproxystate "USB 10/100/1000 LAN" on
  }

  proxy_ethernet_off () {
    sudo networksetup -setwebproxystate "USB 10/100/1000 LAN" off
    sudo networksetup -setsecurewebproxystate "USB 10/100/1000 LAN" off
  }
fi

################################################################################
# misc                                                                         #
################################################################################

hs () {
  history | grep $1
}

mv_if_exists () {
  if [ -f $1 ]; then
    mv $1 $2
  fi
}

################################################################################
# private                                                                      #
################################################################################

if [ -f "$HOME/.bashrc_private" ]; then
  source "$HOME/.bashrc_private"
fi
