#!/bin/bash
old=$(echo "$2" | sed 's/\\/\//g')
new=$(echo "$5" | sed 's/\\/\//g')
path=$(echo "$1" | sed 's/\\/\//g')
git diff --no-index --no-ext-diff "$old" "$new" \
  | sed "s|$old|$path|g; s|$new|$path|g" \
  | delta --width="$LAZYGIT_COLUMNS"
