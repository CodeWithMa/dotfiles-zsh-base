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
