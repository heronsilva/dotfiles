# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# options
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTORY_IGNORE="(ls|cd|pwd|exit|ref|dup|zps|pac|aur)"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="(c|cd|..|ref|dup*|zps|pac|aur)"

# path
path+=($HOME/.local/bin)

# exports
export EDITOR=$(which vim)
export VISUAL=$(which vim)

# custom config
for config (~/.zsh/*.zsh) source $config
for config (~/.zsh/plugins/*.zsh) source $config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
