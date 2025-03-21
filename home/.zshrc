# source ~/.zsh/oh-my-zsh.zsh

# Enable Powerlevel11k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zsh/options.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/plugins.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/keybindings.zsh

source_if_exists ~/.shared-resources.sh

if type fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(mise activate zsh)"
