#!/bin/bash

DOTFILES_PATH=$PWD
TIMESTAMP="$(date +%Y-%m-%d_%H:%M:%S)"
BACKUP_PATH=$HOME/.dotfiles_bkp_$TIMESTAMP

mkdir -p $BACKUP_PATH

function confirm() {
	read -p "$1 [Y/n] " resp
	if [ -z $resp ] || [ ${resp,,} == "y" ]; then
		return 0
	else
		return 1
	fi
}

function backup_if_exists() {
	if [ -e $1 ]; then
		# echo "creating backup for $1"

		if [ ! -d $BACKUP_PATH ]; then
			echo "creating backup directory at $BACKUP_PATH"
			mkdir $BACKUP_PATH
		fi

		# echo "copying $1 to $BACKUP_PATH"
		cp -r $1 $BACKUP_PATH
	fi
}

function install_files() {
	for file in $(ls -A $1); do
		if [ -f $1/$file ]; then
			if confirm "Install $file?"; then
				backup_if_exists $HOME/$file

				relative_path=$(realpath --relative-to $DOTFILES_PATH/home $1/$file)
				parent_dir=$(dirname $relative_path)

				if [ $parent_dir != "." ] && [ ! -z $parent_dir ]; then
					echo "creating directory for symlink"
					mkdir -p $HOME/$parent_dir
				fi

				echo "creating symbolic link for "$1/$file" at $HOME/$relative_path"
				ln -sf $1/$file $HOME/$relative_path
			fi
		elif [ -d $1/$file ]; then
			install_files $1/$file
		fi
	done
}

install_files $DOTFILES_PATH/home
