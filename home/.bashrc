# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Your place for hosting Git repos. I use this for private repos.
# export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
# export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
# export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
# export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
# export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
# export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
# export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Heron's customizations
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

if [ -f ~/.config/pathrc ]; then
  source ~/.config/pathrc
fi

# if [ -f ~/Scripts/git-prompt.sh ]; then
#   source ~/Scripts/git-prompt.sh
# fi

# if [ -f ~/Scripts/git-completion.bash ]; then
#   source ~/Scripts/git-completion.bash
# fi

export TERM=xterm
export SCM_GIT_SHOW_DETAILS=true
export HISTIGNORE=c:cd:..:ref:up:dup:xablau:zps
export HISTCONTROL=ignoreboth:erasedups

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
