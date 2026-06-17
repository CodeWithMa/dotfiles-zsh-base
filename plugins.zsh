#!/bin/zsh

function plugin-load() {
  local plugin_dir plugin_name initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

  for plugin_name in "$@"; do
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh

    if [[ ! -d $plugin_dir ]]; then
      echo >&2 "Plugin '$plugin_name' is missing. Run 'git submodule update --init' in ${ZDOTDIR:-$HOME/.config/zsh}."
      continue
    fi

    if [[ -z "$(ls -A "$plugin_dir" 2>/dev/null)" ]]; then
      echo >&2 "Plugin '$plugin_name' is empty. Run 'git submodule update --init' in ${ZDOTDIR:-$HOME/.config/zsh}."
      continue
    fi

    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin '$plugin_name' has no init file." && continue }
      ln -s "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function plugin-update {
  local zsh_config_dir=${ZDOTDIR:-$HOME/.config/zsh}
  command git -C "$zsh_config_dir" submodule update --remote --merge --init --recursive
  echo "Plugins updated. Commit the new versions:"
  echo "  git -C $zsh_config_dir add plugins/ .gitmodules && git -C $zsh_config_dir commit -m \"update plugins\""
}

# The order is important. See https://github.com/zsh-users/zsh-history-substring-search#usage
plugins=(
  tipz
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  zsh-history-substring-search
)
plugin-load $plugins
