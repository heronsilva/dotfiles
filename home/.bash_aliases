## Zypper
alias    ref="sudo zypper ref"
alias    zyp="sudo zypper install "
alias    rem="sudo zypper remove --clean-deps "
alias     up="sudo zypper update "
alias    dup="sudo zypper dist-upgrade "
alias xablau="ref && dup"
alias    zps="sudo zypper ps -s"

# clear scrollback. see: https://apple.stackexchange.com/a/113168
alias c="clear && printf '\e[3J'"

## Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias kconfig='/usr/bin/git --git-dir=$HOME/.kdotfiles --work-tree=$HOME'

alias histclean='nl ~/.bash_history | sort -k 2  -k 1,1nr| uniq -f 1 | sort -n | cut -f 2 > unduped_history && cp unduped_history ~/.bash_history'

