#!/bin/zsh

# [Home] - Go to beginning of line
bindkey '^[[H' beginning-of-line

# [End] - Go to end of line
bindkey '^[[F' end-of-line

# CTRL Arrow Navigation
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# [Delete] - delete forward
bindkey "^[[3~" delete-char
