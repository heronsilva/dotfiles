## Zypper
alias    ref="sudo zypper ref"
alias    zyp="sudo zypper install "
alias     up="sudo zypper update"
alias    dup="sudo zypper dist-upgrade"
alias xablau="ref && dup"
alias    zps="sudo zypper ps -s"

## Dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias histclean='nl ~/.bash_history | sort -k 2  -k 1,1nr| uniq -f 1 | sort -n | cut -f 2 > unduped_history && cp unduped_history ~/.bash_history'
