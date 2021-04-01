#!/bin/zsh

dotfiles_dir=~/dotfiles

ln -sf $dotfiles_dir/.vimrc ~/.vimrc
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/.zshrc ~/.zshrc

