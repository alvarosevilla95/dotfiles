#!/bin/bash

# general
yes | sudo pacman -S yay &&

# Xmodmap 
rm -rf ~/.Xmodmap;
ln -s ~/.dotfiles/Xmodmap ~/.Xmodmap &&
xmodmap ~/.Xmodmap;

# i3
rm -rf ~/.i3/config;
ln -s ~/.dotfiles/Xmodmap ~/.Xmodmap &&
ln -s ~/.dotfiles/i3-config  ~/.i3/config;
mkdir -p ~/.config/i3status;
rm -rf ~/.config/i3status/config;
ln -s ~/.dotfiles/i3status-config ~/.config/i3status/config;
rm -rf ~/.Xresources;
ln -s ~/.dotfiles/Xresources  ~/.Xresources;

# zsh
sh -c ./install-oh-my-zsh.sh &&
rm -rf ~/.zshrc;
ln -s ~/.dotfiles/zshrc ~/.zshrc &&
rm -rf ~/.oh-my-zsh/custom/themes/cbira.zsh-theme;
ln -s ~/.dotfiles/cbira.zsh-theme ~/.oh-my-zsh/custom/themes/cbira.zsh-theme;

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
rm -rf ~/.vimrc;
ln -s ~/.dotfiles/vimrc ~/.vimrc &&
vim -c :PlugInstall -c :q -c :q &&
rm -rf ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/manjaro.vim;
ln -s ~/.dotfiles/lightline-manjaro.vim ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/manjaro.vim;
yay -S ripgrep &&

# tmux
yes | yay -S tmux &&
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf;

# ssh
mkdir ~/.ssh/;
mkdir -p ~/.config/systemd/user/ &&
rm -rf ~/.ssh/config;
ln -s ~/.dotfiles/ssh-config ~/.ssh/config;
rm -rf ~/.config/systemd/user/ssh-agent.service &&
ln -s ~/.dotfiles/ssh-agent.service ~/.config/systemd/user/ssh-agent.service &&
systemctl --user enable ssh-agent &&
systemctl --user start ssh-agent;

# firefox
yes | yay -S firefox;

# go
yes | yay -S go;
mkdir -p ~/Dev/go/{src,bin,pkg};

# python
yes | yay -S python-pip &&
sudo pip install virtualenv virtualenvwrapper;

chsh -s /usr/bin/zsh

