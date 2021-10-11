#!/bin/bash

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "You are not inside a Git repo."
    exit 1
fi


git reflog | while read line
do
    echo $line
done
