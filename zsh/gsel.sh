#!/usr/bin/sh

PATHS=`locate --regex ".*\.git$"`
PATHS="$(echo "$PATHS" | grep -v --color=NEVER '\.cache\|\.cargo\|emacs\|nvim/lazy\|nvim/mason')"

if OPEN=`echo "$PATHS" | fzf`/..; then
    nvim "$OPEN"
fi

