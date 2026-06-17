#!/bin/zsh

# declare a simple plugin-load function
function plugin-load() {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  local zsh_config_dir=${ZDOTDIR:-$HOME/.config/zsh}
  local lockfile=$zsh_config_dir/plugins.lock
  local tmp_lockfile=$lockfile.tmp

  # ensure plugins directory exists
  mkdir -p $ZPLUGINDIR

  # load lockfile into associative array
  typeset -A PLUGIN_COMMITS
  if [[ -f $lockfile ]]; then
    local line repo_name commit
    while IFS='=' read -r repo_name commit; do
      [[ -z $repo_name || $repo_name == \#* ]] && continue
      PLUGIN_COMMITS[$repo_name]=$commit
    done < $lockfile
  fi

  # clear new lockfile
  > $tmp_lockfile

  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh

    if [[ ! -d $plugin_dir ]]; then
      local commit=${PLUGIN_COMMITS[$repo]}
      if [[ -n $commit ]]; then
        echo "Cloning $repo at $commit"
        git clone -q --recursive https://github.com/$repo $plugin_dir
        git -C $plugin_dir checkout -q $commit
      else
        echo "Cloning $repo (shallow)"
        git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
      fi
    fi

    # record commit to new lockfile
    local current_commit=$(git -C $plugin_dir rev-parse HEAD)
    echo "$repo=$current_commit" >> $tmp_lockfile

    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -s "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done

  mv $tmp_lockfile $lockfile
}

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
  local zsh_config_dir=${ZDOTDIR:-$HOME/.config/zsh}
  local lockfile=$zsh_config_dir/plugins.lock
  local tmp_lockfile=$lockfile.tmp

  # read current lockfile
  typeset -A PLUGIN_COMMITS
  if [[ -f $lockfile ]]; then
    local line repo_name commit
    while IFS='=' read -r repo_name commit; do
      [[ -z $repo_name || $repo_name == \#* ]] && continue
      PLUGIN_COMMITS[$repo_name]=$commit
    done < $lockfile
  fi

  # clear new lockfile
  > $tmp_lockfile

  for d in $ZPLUGINDIR/*/.git(/); do
    local plugin_dir=${d:h}
    local plugin_name=${plugin_dir:t}
    local repo

    # find repo name from git remote
    repo="$(git -C $plugin_dir remote get-url origin 2>/dev/null | sed 's|.*github.com/||; s|\.git$||')"
    [[ -z $repo ]] && continue

    echo "Updating $repo..."
    local default_branch
    default_branch="$(git -C $plugin_dir symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')"
    [[ -z $default_branch ]] && default_branch=main
    git -C $plugin_dir fetch -q origin $default_branch
    git -C $plugin_dir checkout -q $default_branch
    git -C $plugin_dir pull --ff --recurse-submodules --rebase --autostash

    local new_commit
    new_commit="$(git -C $plugin_dir rev-parse HEAD)"
    print -r -- "$repo=$new_commit" >> $tmp_lockfile
  done

  mv $tmp_lockfile $lockfile
  echo "Lockfile updated. Commit it to share these versions:"
  echo "  git -C $zsh_config_dir add plugins.lock && git -C $zsh_config_dir commit -m \"update plugins\""
}

# make a github repo plugins list
plugins=(
  molovo/tipz
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
)
# Usage:
#   plugin-load $plugins   # load plugins (clones at pinned lockfile commits, falls back to HEAD for new plugins)
#   plugin-update          # update plugins and lockfile (commit the result)