#!/bin/bash

# general
sudo pacman -S yay &&
yay -S firefox;

# Xmodmap 
ln -s ~/.dotfiles/Xmodmap ~/.Xmodmap &&
xmodmap ~/.Xmodmap;

# i3
ln -s ~/.dotfiles/i3-config  ~/.i3/config;
ln -s ~/.dotfiles/Xresources  ~/.Xresources;

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
ln -s ~/.dotfiles/zshrc ~/.zshrc &&
ln -s ~/.dotfiles/cbira.zsh-theme ~/.oh-my-zsh/custom/themes/cbira.zsh-theme;

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
ln -s ~/.dotfiles/vimrc ~/.vimrc &&
ln -s ~/.dotfiles/lightline-manjaro.vim ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/manjaro.vim;

# tmux
yay -S tmux &&
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf;

# ssh
mkdir -p ~/.config/systemd/user/ &&
ln -s ~/.dotfiles/ssh-config ~/.ssh/config
ln -s ~/.dotfiles/ssh-agent.service ~/.config/systemd/user/ssh-agent.service &&
systemctl --user enable ssh-agent &&
systemctl --user start ssh-agent;

