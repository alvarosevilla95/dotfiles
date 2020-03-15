#!/bin/bash

# installs
yes | sudo pacman -S yay
yes | yay -S firefox
yes | yay -S ripgrep
yes | yay -S go
yes | yay -S python-pip
yes | yay -S tmux

mkdir -p ~/.config/systemd/user/
ln -s ~/.dotfiles/ssh-agent.service ~/.config/systemd/user/ssh-agent.service

# Xresources
ln -sf ~/.dotfiles/Xresources ~/.Xresources
ln -sf ~/.dotfiles/Xmodmap ~/.Xmodmap
xmodmap ~/.Xmodmap

# i3
mkdir -p ~/.config/i3status
ln -s ~/.dotfiles/i3status-config ~/.config/i3status/config
ln -sf ~/.dotfiles/i3-config ~/.i3/config

# ssh
mkdir ~/.ssh/ 
ln -sf ~/.dotfiles/ssh-config ~/.ssh/config
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

# go
mkdir -p ~/Dev/go/{src,bin,pkg}

# python
sudo pip install virtualenv virtualenvwrapper

# set shell
chsh -s /usr/bin/zsh
