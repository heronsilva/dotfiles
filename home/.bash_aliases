# pacman
alias pac="sudo pacman -Syyu --needed"
alias aur="sudo aura -Akua"
alias rmo="pacman -Qtdq | sudo pacman -Rns -"

# clear scrollback. see: https://apple.stackexchange.com/a/113168
alias c="clear && printf '\e[3J'"

# deduplicate history
alias histclean='nl ~/.bash_history | sort -k 2  -k 1,1nr| uniq -f 1 | sort -n | cut -f 2 > unduped_history && cp unduped_history ~/.bash_history'
