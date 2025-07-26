# Set up zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load zinit annexes
zinit snippet OMZ::lib/compfix.zsh
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/git.zsh

zinit light zdharma-continuum/zinit-annex-as-monitor
zinit light zdharma-continuum/zinit-annex-patch-dl
zinit light zdharma-continuum/zinit-annex-rust

zinit ice depth=1; zinit light romkatv/powerlevel10k

# Essential interactive plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light MichaelAquilina/zsh-you-should-use

# OMZ plugins and utilities
is_installed git && zinit snippet OMZ::plugins/git/git.plugin.zsh
is_installed docker && is_not_alias docker && zinit snippet OMZ::plugins/docker/docker.plugin.zsh
# is_installed podman && zinit snippet OMZ::plugins/podman/podman.plugin.zsh

zinit snippet OMZ::plugins/extract/extract.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/globalias/globalias.plugin.zsh # expands glob expressions, subcommands and aliases

zinit snippet OMZ::plugins/mise/mise.plugin.zsh

# Performance-related
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
zinit light zdharma-continuum/zinit-annex-bin-gem-node
