#!/bin/bash

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
    mv "$HOME/$file" ~/Documents/GIT/dotfiles_old/
    echo "Creating symlink to $file in home"
    ln -s "$dir/$file" "$HOME/$file"
done

# we need fish already installed for this
# because we want to install oh-my-fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/tools/install.fish | fish &

mv ~/.config/fish/config.{fish,orig}

ln -s $dir/fish/config.fish ~/.config/fish/config.fish
ln -s $dir/fish/functions ~/.config/fish/functions
ln -s $dir/fish/custom_config.load ~/.oh-my-fish/custom/custom_configuration.load
ln -s $dir/fish/themes/sn3rd ~/.oh-my-fish/themes/sn3rd

fish -c "omf install" &


source ~/.vimrc
