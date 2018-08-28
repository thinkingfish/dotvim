#!/bin/sh

# move existing vimrc if it already exists
if [ -f "$HOME/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.backup
fi
ln -s ~/.vim/vimrc ~/.vimrc
