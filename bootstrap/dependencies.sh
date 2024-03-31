function confirm() {
	local dependency=$1
	read -p "Install $dependency? [Y/n] " resp
	if [[ ! $resp =~ ^[Yy]?$ ]]; then
		return 1
	fi
	return 0
}

if confirm "oh-my-zsh"; then
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	printf "Done installing oh-my-zsh \n"
fi

if confirm "bash-it"; then
	git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	sh ~/.bash_it/install.sh
	printf "Done installing bash-it \n"
fi

if confirm "vim-plug"; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	printf "Done installing vim-plug \n"
fi

if confirm "tmux tpm"; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpms
	printf "Done installing tmux plugin manager \n"
fi
