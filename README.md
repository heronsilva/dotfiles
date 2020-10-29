# My dotfiles repo

## Created and managed following the _git bare repo_ approach. See:
- [Ask HN: What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)
- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

## Replicating the dotfiles on a new system installation:

### Installation script
You can simply run the installation script with the following command:
```shell
curl -o- https://raw.githubusercontent.com/heronsilva/dotfiles/master/Scripts/dotfiles-installation.sh | bash
```

Alternatively, with `wget`:
```shell
wget -qO- https://raw.githubusercontent.com/heronsilva/dotfiles/master/Scripts/dotfiles-installation.sh | bash
```

### You can also go step by step, if you prefer
Firstly, we'll create a `config` alias for managing your repo with GIT:
```shell
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

In order to prevent GIT recursion issues, add the following directory to `$HOME/.gitignore`
```shell
echo ".dotfiles/" >> .gitignore
```

Cloning the _bare_ repo:
```shell
git clone --bare git@github.com:heronsilva/dotfiles.git $HOME/.dotfiles
```

Checkout the actual content from the bare repository to your $HOME:
```shell
config checkout
```

To avoid `config status` (`git status`) display every untracked file, you can set:
```shell
config config --local status.showUntrackedFiles no
```

Now, you can start tracking your dotfiles with GIT using the `config` alias:
```shell
config status

config add .vimrc
config commit -m "add vimrc"

config add .bashrc
config commit -m "add bashrc"

config push
```
