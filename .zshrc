#!/bin/zsh

export ZSH_CONFIG_DIR="${${(%):-%N}:A:h}"

source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/bindkeys.zsh"
source "$ZSH_CONFIG_DIR/config-update.zsh"
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/history.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/zoxide.zsh"
source "$ZSH_CONFIG_DIR/zsh-history-substring-search.zsh"
source "$ZSH_CONFIG_DIR/zsh.zsh"

eval "$(starship init zsh)"
