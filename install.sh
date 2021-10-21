#!/bin/sh

for folder in */ ; do
	stow $folder
done

