function confirm() {
	local dependency=$1
	read -p "Install $dependency? [Y/n] " resp
	if [[ ! $resp =~ ^[Yy]?$ ]]; then
		return 1
	fi
	return 0
}

# install dependencies
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "Installing linux dependencies"

	DISTRO=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
	if [ $DISTRO == "arch" ] || [ $DISTRO == "manjaro" ]; then
		sudo pacman -Syu --noconfirm
		sudo pacman -S --noconfirm --needed \
			alacritty \
			base-devel \
			bat \
			curl \
			fzf \
			gcc \
			git \
			htop \
			jq \
			neovim \
			tmux \
			vim \
			wget \
			zsh
	elif [ $DISTRO == "ubuntu" ] || [ $DISTRO == "debian" ]; then
		sudo apt update
		sudo apt install -y \
			asdf \
			bat \
			docker \
			fzf \
			gawk \
			gh \
			git \
			jq \
			neovim \
			tmux \
			trash-cli
		sudo apt install -y \
			alacritty \
			fig \
			fonts-iosevka \
			fonts-jetbrains-mono \
			raycast \
			warp
	else
		echo "Unknown distro"
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo "Installing OSX dependencies"

	# homebrew
	if [ ! -f /opt/homebrew/bin/brew ] && confirm "homebrew"; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew update
	brew install \
		asdf \
		bat \
		docker \
		docker-completion \
		fzf \
		gawk \
		gh \
		git \
		jq \
		neovim \
		tmux \
		trash-cli
	brew install --cask \
		alacritty \
		fig \
		font-iosevka \
		font-iosevka-nerd-font \
		font-jetbrains-mono \
		font-jetbrains-mono-nerd-font \
		raycast \
		warp
else
	echo "unknown os"
fi

# install user dependencies
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
