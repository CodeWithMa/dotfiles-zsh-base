#!/bin/zsh

config-update() {
  local gitdir repo

  while IFS= read -r -d '' gitdir; do
    repo="${gitdir%/.git}"

    printf '\n--- %s ---\n' "$repo"

    git -C "$repo" pull --ff-only || \
      echo "Skipped (non fast-forward)"
  done < <(
    find "$HOME/.config" -type d -name .git -prune -print0
  )
}
