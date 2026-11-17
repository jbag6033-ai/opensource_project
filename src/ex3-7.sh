#!/bin/sh
set -e
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "사용법: sh $0 폴더이름" >&2; exit 1
fi
case "$1" in /*|./*|../*) dir=$1 ;; *) dir=./$1 ;; esac
for i in 0 1 2 3 4; do
    for path in "$dir/file$i.txt" "$dir/file$i"; do
        if [ -e "$path" ] || [ -L "$path" ]; then
            echo '같은 이름의 실습 자료가 있습니다.' >&2; exit 1
        fi
    done
done
mkdir -p "$dir"
for i in 0 1 2 3 4; do
    printf 'link sample %s\n' "$i" > "$dir/file$i.txt"
    mkdir "$dir/file$i"
    ln -s "file$i.txt" "$dir/file$i/file$i.txt"
done
