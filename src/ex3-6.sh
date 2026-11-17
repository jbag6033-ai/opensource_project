#!/bin/sh
set -e
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "사용법: sh $0 폴더이름" >&2; exit 1
fi
case "$1" in /*|./*|../*) dir=$1 ;; *) dir=./$1 ;; esac
mkdir -p "$dir"
# 파일 생성 전에 기존 실습 자료와 충돌하는지 확인한다.
for i in 1 2 3 4 5; do
    if [ -e "$dir/file$i.txt" ] || [ -L "$dir/file$i.txt" ]; then
        echo '실습 파일이 이미 있습니다.' >&2; exit 1
    fi
done
archive="$dir/files.tar.gz"
if [ -e "$archive" ] || [ -L "$archive" ]; then
    echo '압축 파일이 이미 있습니다.' >&2; exit 1
fi
for i in 1 2 3 4 5; do
    printf 'sample file %s\n' "$i" > "$dir/file$i.txt"
done
tar -czf "$archive" -C "$dir" file1.txt file2.txt file3.txt file4.txt file5.txt
unpacked=$(mktemp -d "$dir/extracted.XXXXXX")
tar -xzf "$archive" -C "$unpacked"
printf '압축 파일: %s\n압축 해제 폴더: %s\n' "$archive" "$unpacked"
ls -l "$unpacked"
