#!/bin/bash

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "You are not inside a Git repo."
    exit 1
fi

reflog=$(git reflog 2>&1)

for line in $reflog
do
    echo $line
done
