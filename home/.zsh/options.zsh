autoload -Uz compinit
compinit

# Simple autojump implementation
# https://duganchen.ca/the-simplest-autojump-implementation-for-zsh/
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert always
alias j=cdr

zstyle ':completion:*' menu select

setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"  # Makes the suggestion text lighter.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(builtin)  # You can customize what to highlight.
# HISTORY_IGNORE="(l ls la ll)"
# ZSH_AUTOSUGGEST_HISTORY_IGNORE="()"

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS
setopt CDABLE_VARS
setopt GLOB_DOTS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt NOMATCH
setopt PROMPT_SUBST
# setopt AUTO_NAME_DIRS
