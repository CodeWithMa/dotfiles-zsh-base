#!/bin/zsh

alias syu='sudo pacman --color auto -Syu'
alias syuw='sudo pacman --color auto -Syuw'

# shortcuts
alias clr='clear'
alias df='df -h'
alias en='LANG=en_US.UTF-8'
alias g='git'
alias ip='ip -c=auto'
alias n='nload'
alias v='nvim'

alias _='sudo'

# My ls -lah / eza
alias l='eza -la --group-directories-first --git'

# bat instead of cat no Pager and no linenumbers
alias cat='bat -p -P'

# prettyping instead of ping
alias ping='prettyping'
