#!/usr/bin/env bash

function update_git {
    pwd | c=$0
    cd $1
    content="$(cut -d' ' -f1 <<< `ls -a | grep .git | wc -l`)"
    if [[ ${content} -gt 0 ]]; then
        echo $1
        git pull
    fi
    cd ${c}
}

pwd | d=$0
base_dir=/ # you need to edit to your repos
cd ${base_dir}
list="$(ls -d */)"
count="$(cut -d' ' -f1 <<< `ls -d */ | wc -l`)"

for (( i=1; i <= $count; i++ )) do
    target="$(cut -d' ' -f${i} <<< ${list})"
    path="$base_dir$target"
    update_git ${path}
done

