cd ~
xcode-select --install
git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
ln -s ./.dotfiles/.fixpackrc .fixpackrc
ln -s ./.dotfiles/.tmux.conf .tmux.conf
ln -s ./.dotfiles/.zshrc .zshrc
source .zshrc
