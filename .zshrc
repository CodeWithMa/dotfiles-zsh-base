#!/bin/zsh

local zsh_config_dir="${0:A:h}"

source "$zsh_config_dir/aliases.zsh"
source "$zsh_config_dir/bindkeys.zsh"
source "$zsh_config_dir/config-update.zsh"
source "$zsh_config_dir/exports.zsh"
source "$zsh_config_dir/history.zsh"
source "$zsh_config_dir/plugins.zsh"
source "$zsh_config_dir/zoxide.zsh"
source "$zsh_config_dir/zsh-history-substring-search.zsh"
source "$zsh_config_dir/zsh.zsh"

eval "$(starship init zsh)"
