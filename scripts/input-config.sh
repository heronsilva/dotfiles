export HISTCONTROL=$HISTCONTROL:erasedups

bind '"\t":menu-complete'

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
