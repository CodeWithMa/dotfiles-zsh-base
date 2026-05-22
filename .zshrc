#!/bin/zsh

source ./zsh/aliases.zsh
source ./zsh/bindkeys.zsh
source ./zsh/exports.zsh
source ./zsh/history.zsh
source ./zsh/plugins.zsh
source ./zsh/zoxide.zsh
source ./zsh/zsh-history-substring-search.zsh
source ./zsh/zsh.zsh

eval "$(starship init zsh)"
