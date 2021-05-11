#!/bin/zsh

mkdir -p ~/.config/nvim/plugin

dotfiles_dir=~/dotfiles

ln -sf $dotfiles_dir/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $dotfiles_dir/nvim/coc.vim ~/.config/nvim/plugin/coc.vim
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/.zshrc ~/.zshrc

