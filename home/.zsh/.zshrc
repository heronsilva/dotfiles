
# Enable Powerlevel11k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path  # Make sure PATH entries are unique

source $HOME/.zsh/options.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/plugins.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/keybindings.zsh
source $HOME/.zsh/exports.zsh

command -v fzf >/dev/null && source <(fzf --zsh)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

is_installed mise && eval "$($HOME/.local/bin/mise activate zsh)"
is_installed direnv && eval "$(direnv hook zsh)"
is_installed yarn path+=$(yarn global bin)

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
