#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

branch="$(git rev-parse --abbrev-ref HEAD)"
commitRegex='(hotfix|bugs|feature|update)([-])([a-zA-Z0-9]\w+)([-])([a-zA-Z0-9]\w+)'

if [ "$branch" = "master" ]; then
  exit 0
fi

if [ "$branch" = "develop" ]; then
  exit 0
fi

if ! grep -qE "$commitRegex" "$branch"; then
  echo "You can't commit directly to master branch, $branch"
  exit 1
fi
