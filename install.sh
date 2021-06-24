#!/bin/zsh

mkdir -p ~/.config/nvim/plugin
mkdir -p ~/.config/alacritty

dotfiles_dir=~/dotfiles

ln -sf $dotfiles_dir/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $dotfiles_dir/nvim/coc.vim ~/.config/nvim/plugin/coc.vim
ln -sf $dotfiles_dir/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/.zshrc ~/.zshrc
ln -sf $dotfiles_dir/.tmux.conf ~/.tmux.conf

