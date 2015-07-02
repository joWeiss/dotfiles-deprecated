#!/bin/sh

### vars
dir=~/Documents/GIT/dotfiles
olddir=~/Documents/GIT/dotfiles_old
files=".tmux.conf .vimrc .vim .latexmkrc .ls++.conf"


# create backup dir for old files
echo "Creating $olddir for backups of any existing dotfiles..."
mkdir -p $olddir
echo "...done"

# change to dotfiles dir
echo "Changing cwd to $dir"
cd $dir
echo "...done"

# move existing files in homedir to dotfiles_old, then create new symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/Documents/GIT/dotfiles_old/
    echo "Creating symlink to $file in home"
    ln -s $dir/$file ~/$file
done

source ~/.vimrc
