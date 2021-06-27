cd ~
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install tmux
brew install fnm
git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
ln -s ./.dotfiles/.fixpackrc .fixpackrc
ln -s ./.dotfiles/.p10k.zsh .p10k.zsh
ln -s ./.dotfiles/.tmux.conf .tmux.conf
ln -s ./.dotfiles/.zshrc .zshrc
source .zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
source .zshrc
