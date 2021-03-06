#!/bin/bash
rebase_regex="^([a-z]|[0-9]){7} HEAD@{[0-9]+}: rebase \(start\).+$"
ref_id_regex="^(([a-z]|[0-9]){7}).+$"

. ./utils/ensure-git-repo.sh
. ./utils/theme.sh

reset=false

confirm_reset () {
    read -p "Undo $1? This will also undo anything you did after. [y/n]: " input </dev/tty

    if [[  $input =~ ^y|yes$ ]]
    then
        echo "Resetting to $2"
        reset_to_ref $2
    fi
    reset=false
}

reset_to_ref () {
    git reset --hard $1
}

git reflog | while read line
do
    if [[ $reset != false ]]
    then
        ref_id=`echo $line | sed -E "s/$ref_id_regex|.*/\1/"`
        confirm_reset "rebase" $ref_id
    else
        if [[ $line =~ $rebase_regex ]]
        then
            echo "Detected a recent rebase."
            reset=true
        fi
    fi
done
