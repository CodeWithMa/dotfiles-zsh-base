#!/bin/zsh

source ./.config/zsh/aliases.zsh
source ./.config/zsh/bindkeys.zsh
source ./.config/zsh/config-update.zsh
source ./.config/zsh/exports.zsh
source ./.config/zsh/history.zsh
source ./.config/zsh/plugins.zsh
source ./.config/zsh/zoxide.zsh
source ./.config/zsh/zsh-history-substring-search.zsh
source ./.config/zsh/zsh.zsh

eval "$(starship init zsh)"
