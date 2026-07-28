#!/bin/zsh

export TERMINAL="alacritty"
export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export SPICE_NOGRAB=1

# Load secrets
if [[ -f /var/run/secrets/"$(whoami)"-env ]]; then
  set -a
  source /var/run/secrets/"$(whoami)"-env
  set +a
fi
