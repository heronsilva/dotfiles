alias c=clear && printf '\e[3J'
alias gswr="git switch release-dev"
alias nv=$(which nvim)
alias xablau="npm run dev:debug"
alias xcurl="curl -o /dev/null -s -w %{time_total}"

# .oh-my-zsh/lib/directories.zsh
# Changing directory
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# List directory contents
alias l='ls -lAh'
alias ll='ls -lh'
alias la='ls -lah'

# Docker Compose
alias dco="docker compose"
alias dcb="docker compose build"
alias dce="docker compose exec"
alias dcps="docker compose ps"
alias dcrestart="docker compose restart"
alias dcrm="docker compose rm"
alias dcr="docker compose run"
alias dcstop="docker compose stop"
alias dcup="docker compose up"
alias dcupb="docker compose up --build"
alias dcupd="docker compose up -d"
alias dcupdb="docker compose up -d --build"
alias dcdn="docker compose down"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dclF="docker compose logs -f --tail 0"
alias dcpull="docker compose pull"
alias dcstart="docker compose start"
alias dck="docker compose kill"
