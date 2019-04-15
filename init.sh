#!/bin/bash

# installs
yes | sudo pacman -S yay;
yes | yay -S firefox;
yes | yay -S ripgrep;
yes | yay -S go;
yes | yay -S python-pip;
yes | yay -S tmux;

# vim
mkdir -p ~/.vim/autoload/; cp ~/.dotfiles/vim.plug ~/.vim/autoload/plug.vim;
vim -c :PlugInstall -c :q -c :q;

# zsh
sh -c ./install-oh-my-zsh.sh;

# python
sudo pip install virtualenv virtualenvwrapper;

# links
rm -rf ~/.Xmodmap; ln -s ~/.dotfiles/Xmodmap ~/.Xmodmap;
rm -rf ~/.config/i3status/config; mkdir -p ~/.config/i3status; ln -s ~/.dotfiles/i3status-config ~/.config/i3status/config;
rm -rf ~/.i3/config; ln -s ~/.dotfiles/i3-config ~/.i3/config;
rm -rf ~/.Xresources; ln -s ~/.dotfiles/Xresources ~/.Xresources;
rm -rf ~/.zshrc; ln -s ~/.dotfiles/zshrc ~/.zshrc;
rm -rf ~/.oh-my-zsh/custom/themes/cbira.zsh-theme; ln -s ~/.dotfiles/cbira.zsh-theme ~/.oh-my-zsh/custom/themes/cbira.zsh-theme;
rm -rf ~/.vimrc; ln -s ~/.dotfiles/vimrc ~/.vimrc;
rm -rf ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/manjaro.vim; ln -s ~/.dotfiles/lightline-manjaro.vim ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/manjaro.vim;
rm -rf ~/.tmux.conf; ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf;
rm -rf ~/.ssh/config; mkdir ~/.ssh/; ln -s ~/.dotfiles/ssh-config ~/.ssh/config;
rm -rf ~/.config/systemd/user/ssh-agent.service; mkdir -p ~/.config/systemd/user/; ln -s ~/.dotfiles/ssh-agent.service ~/.config/systemd/user/ssh-agent.service;

# ssh
systemctl --user enable ssh-agent;
systemctl --user start ssh-agent;

# go
mkdir -p ~/Dev/go/{src,bin,pkg};

xmodmap ~/.Xmodmap;

chsh -s /usr/bin/zsh;
