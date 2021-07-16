#!/bin/zsh

for folder in */ ; do
	stow $folder
done

