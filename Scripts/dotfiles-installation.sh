#!/bin/bash

REPO_URL=https://github.com/heronsilva/dotfiles.git
DEST_PATH=$HOME/.dotfiles
BACKUP_PATH=$HOME/.dotfiles-backup

rm -rf ~/.dotfiles
rm -rf ~/.dotfiles-backup

git clone --bare $REPO_URL $DEST_PATH 

function config {
  /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
}

config checkout

if [ $? = 0 ]; then
  echo "Checked out .dotfiles";
else
  echo "Backing up pre-existing dot files";
  mkdir -p BACKUP_PATH 

  files=`config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}`

  for file in $files
  do
    directory=`dirname $BACKUP_PATH/$file`
    echo 'Creating directory' $directory
    mkdir --parents $directory

    echo 'Moving file ' $file
    mv $file $BACKUP_PATH
  done
fi;

config checkout
config config status.showUntrackedFiles no

