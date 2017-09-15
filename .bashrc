##############
# cd scripts #
##############

alias cdp="cd /media/sf_Projects/"

###############
# git scripts #
###############

git_personalconfig () {
  git config user.name "Mikhail Bashkirov"
  git config user.email "bashmish@gmail.com"
}

git_ingconfig () {
  git config user.name "Mikhail (M) Bashkirov"
  git config user.email "mikhail.bashkirov@ing.nl"
}

#######
# nvm #
#######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###################
# polymer scripts #
###################

polymer_vbserve () {
  polymer serve --hostname 10.0.2.15
}

####################
# workflow scripts #
####################

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
