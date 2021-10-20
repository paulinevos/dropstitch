#!/bin/bash
ref_regex="^(([a-z]|[0-9]){7}) HEAD@{[0-9]+}: (rebase|reset):? .+$"
moves=(rebase reset)


if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "You are not inside a Git repo."
    exit 1
fi


git reflog | while read line
do
    if [[ $line =~ $ref_regex ]]
    then
        move=`echo $line | sed -E "s/$ref_regex|.*/\3/"`
        ref=`echo $line | sed -E "s/$ref_regex|.*/\1/"`
        echo $move $ref
    fi
done

find_ref_id () {
    return echo $1 | sed -E "s/$ref_regex|.*/\1/"
}

in_array () {
    for i in "${2[@]}"
    do
        if [ "$i" = "$1" ] ; then
            return true
        fi
    done
    return false
}
