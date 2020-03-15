echo "installing oh my zsh"
sh -c ~/dotfiles/zsh/install-oh-my-zsh.sh
echo "linking ~/dotfiles/zsh/zshrc -> ~/.zshrc"
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc
