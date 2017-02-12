#!/bin/bash

if [[ $# != 1 ]]; then
    echo "Usage: $0 <eval_txt>"
    exit 0
fi

eval_txt=$1

function get_numbers() {
    keyword="$1"
    grep "$keyword" $eval_txt | awk '{print $(NF)}'
}

function mean() {
    numbers="$1"
    echo "$numbers" | awk '{sum += $1} END {mean = sum/NR; print mean}'
}

# mAP
numbers=$(get_numbers "average precision")
printf 'mAP:  %f\n' $(mean "$numbers")

numbers=$(get_numbers "NDCG")
printf 'NDCG: %f\n' $(mean "$numbers")

numbers=$(get_numbers "F1")
printf 'F1:   %f\n' $(mean "$numbers")

