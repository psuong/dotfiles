#!/bin/sh

cwd=$(pwd)

if [ -e $HOME/.bashrc ]
then
    mv $HOME/.bashrc $HOME/.bashrc.orig
fi

if [ -e $HOME/.bash_profile ]
then
    mv $HOME/.bash_profile $HOME/.bash_profile.orig
fi

cd $HOME

ln -s $cwd/.bash_profile .bash_profile

if [ -d .config ]
then
    if [ -d .config/nvim ] 
    then
        mv .config/nvim .config/nvim.orig/
    fi
    ln -s $cwd/.config/* $HOME/.config
else
    echo else
    ln -s $cwd/.config/ $HOME/.config/
fi
ln -s $cwd/.vim $HOME/.vim
ln -s $cwd/.git-prompt.sh $HOME/.git-prompt.sh
ln -s $cwd/.tmux.conf $HOME/.tmux.conf

cd $cwd
