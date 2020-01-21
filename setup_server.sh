#!/bin/sh
scp vimrc $1:.vimrc &&
scp -r vim $1:.vim &&
scp  tmux.conf $1:.tmux.conf




