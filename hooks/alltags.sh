#!/bin/bash

alltags() {
    IMG="$1"
    curl -qsL "https://github.com/docker-library/official-images/raw/master/library/${IMG}" | 
        grep "Tags:" |
        sed "s/Tags: //g" |
        while read -r line; do
            for tag in ${line//,/ }; do
                echo "$tag"
            done
        done
}

inverse() {
    awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}