#!/bin/zsh
# bindkeys for arrow up and down
# for https://github.com/zsh-users/zsh-history-substring-search
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# make sure all search results returned are unique
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE='true'
