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
  alias cdp="cd /Users/bashmish/Files/Projects/"
else
  alias cdp="cd /media/sf_Projects/"
fi

################################################################################
# git scripts                                                                  #
################################################################################

git_personalconfig () {
  git config user.name "Mikhail Bashkirov"
  git config user.email "bashmish@gmail.com"
}

git_ingconfig () {
  git config user.name "Mikhail (M) Bashkirov"
  git config user.email "mikhail.bashkirov@ing.nl"
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
  polymer serve --hostname 10.0.2.15
}
alias pvbs="polymer_virtualbox_serve"

################################################################################
# proxy scripts                                                                #
################################################################################

proxy_on () {
  export http_proxy="http://localhost:3128"
  export https_proxy="http://localhost:3128"
  export ftp_proxy="http://localhost:3128"
  export rsync_proxy="http://localhost:3128"
  export ssh_proxy="http://localhost:3128"
}

proxy_off () {
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

  alias resolver_on="/etc/resolver/on.sh"
  alias resolver_off="/etc/resolver/off.sh"
fi

################################################################################
# workflow scripts                                                             #
################################################################################

hs () {
  history | grep $1
}

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
