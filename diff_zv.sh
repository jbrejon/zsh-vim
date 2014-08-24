#!/bin/sh
echo "###################### DIRCOLORS ########################"
diff .dircolors ~/.dircolors
echo "######################  .INDENT  ########################"
diff .indent.pro ~/.indent.pro
echo "######################   VIMRC   ########################"
diff .vimrc ~/.vimrc
echo "######################   ZSHRC   ########################"
diff .zshrc ~/.zshrc
echo "###################### OH-MY-ZSH ########################"
diff -r .oh-my-zsh ~/.oh-my-zsh
echo "######################   .VIM/   ########################"
diff -r .vim ~/.vim
