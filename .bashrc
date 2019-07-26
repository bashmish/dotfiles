export DOTFILES=$HOME/.dotfiles

################################################################################
# bash-it                                                                      #
################################################################################

export BASH_IT="$HOME/.bash_it"

if [ -f "$BASH_IT/bash_it.sh" ]; then
  # theme from $BASH_IT/themes/
  export BASH_IT_THEME='nwinkler'

  # version control status checking
  export SCM_CHECK=true

  # load
  source "$BASH_IT/bash_it.sh"
fi

################################################################################
# bash                                                                         #
################################################################################

shopt -s autocd

################################################################################
# cd scripts                                                                   #
################################################################################

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cdp="cd ~/Files/Projects/"
else
  alias cdp="cd /media/sf_Projects/"
fi

################################################################################
# git scripts                                                                  #
################################################################################

alias stree='/Applications/SourceTree.app/Contents/Resources/stree'

git_personalconfig () {
  git config user.name "Mikhail Bashkirov"
  git config user.email "bashmish@gmail.com"
}

git_ingconfig () {
  git config user.name "Mikhail Bashkirov"
  git config user.email "mikhail.bashkirov@ing.com"
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
# nvm                                                                          #
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

################################################################################
# polymer scripts                                                              #
################################################################################

polymer_virtualbox_serve () {
  if [ -z "$1" ]; then
    polymer serve --hostname 0.0.0.0
  else
    polymer serve --hostname 0.0.0.0 --port $1
  fi
}
alias pvbs="polymer_virtualbox_serve"

################################################################################
# caddy scripts                                                                #
################################################################################

alias caddy="/usr/local/bin/caddy -conf $DOTFILES/Caddyfile_frontend_app"

################################################################################
# proxy scripts                                                                #
################################################################################

proxy_on () {
  unbackpmrc
  proxy_env_vars_on
  proxy_wifi_on
  proxy_ethernet_on
}

proxy_off () {
  backpmrc
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
# workflow scripts                                                             #
################################################################################

hs () {
  history | grep $1
}

function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }

mvifexists () {
  if [ -f $1 ]; then
    mv $1 $2
  fi
}

backpmrc () {
  mvifexists ~/.bowerrc ~/_bowerrc
  mvifexists ~/.npmrc ~/_npmrc
  mvifexists ~/.yarnrc ~/_yarnrc
}

unbackpmrc () {
  mvifexists ~/_bowerrc ~/.bowerrc
  mvifexists ~/_npmrc ~/.npmrc
  mvifexists ~/_yarnrc ~/.yarnrc
}

reinstallnodeselenium () {
  rm -rf ./node_modules/selenium-standalone/.selenium
  ./node_modules/selenium-standalone/bin/selenium-standalone install
}

################################################################################
# private                                                                      #
################################################################################

if [ -f "$HOME/.bashrc_private" ]; then
  source "$HOME/.bashrc_private"
fi
