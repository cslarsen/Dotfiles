#!/bin/bash

function symlink() {
  # Don't overwrite files, dirs or links
  if [ ! -e $HOME/$1 ] && \
     [ ! -d $HOME/$1 ] && \
     [ ! -L $HOME/$1 ];
  then
    echo "Symlinking $HOME/$1"
    ln -s `pwd`/$1 $HOME/$1
  else
    echo "Already have $1"
  fi
}

echo "Updating git submodules"
git submodule update --init --recursive

symlink .bash_profile
symlink .bc
symlink .inputrc
symlink .oh-my-zsh
symlink .tmux
symlink .tmux.conf
symlink .vimrc
symlink .zshrc
symlink .pythonrc
symlink .psqlrc

echo ""
echo Telling git to use core pager, previous setting was: \
  \"`git config --get core.pager`\"
git config --global core.pager ''

echo ""
echo "Installing vim modules, if you have vimp"
which vimp &>/dev/null && vimp get \
  colorcolumn \
  ctrlp \
  dispatch \
  forcequit@ctrl-x \
  fugitive \
  invnumber@ctrl-n \
  molokai \
  nerdcommenter \
  nerdtree@ctrl-d \
  nohlsearch@ctrl-o \
  powerline \
  surround \
  tabs@ctrl-lhtk \
  taglist@ctrl-a \
  undotree@ctrl-u

echo ""
echo "Installing scripts into $HOME/bin"
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
symlink bin/g
symlink bin/gi
