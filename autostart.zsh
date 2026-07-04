#!/bin/zsh

# Autostart btop on vms tty1
if systemd-detect-virt -q; then
  if [[ "$(tty)" == "/dev/tty1" ]]; then
    # Only start if it's an interactive shell and btop isn't already running
    if [[ -o interactive ]] && ! pgrep -x btop >/dev/null; then
      exec btop
    fi
  fi
fi
