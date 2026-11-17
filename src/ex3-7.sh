#!/bin/sh
set -e
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "사용법: sh $0 폴더이름" >&2; exit 1
fi
case "$1" in /*|./*|../*) dir=$1 ;; *) dir=./$1 ;; esac
mkdir -p "$dir"
for i in 1 2 3 4 5; do
    for path in "$dir/file$i.txt" "$dir/file$i"; do
        if [ -e "$path" ] || [ -L "$path" ]; then
            echo '같은 이름의 실습 파일 또는 폴더가 있습니다.' >&2; exit 1
        fi
    done
done
for i in 1 2 3 4 5; do
    printf 'link sample %s\n' "$i" > "$dir/file$i.txt"
    mkdir "$dir/file$i"
    ln -s "../file$i.txt" "$dir/file$i/file$i.txt"
done
find "$dir" -type f -print
for i in 1 2 3 4 5; do ls -l "$dir/file$i"; done
