#!/bin/sh
set -e
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "사용법: sh $0 폴더이름" >&2; exit 1
fi
case "$1" in /*|./*|../*) dir=$1 ;; *) dir=./$1 ;; esac
name=$(basename "$dir")
case "$name" in .|..|/) echo '작업 폴더 이름을 지정하세요.' >&2; exit 1 ;; esac
archive="$dir/files.tar"
unpacked="$dir/$name"
# 기존 파일이나 압축 해제 폴더는 덮어쓰지 않는다.
for path in "$archive" "$unpacked"; do
    if [ -e "$path" ] || [ -L "$path" ]; then
        echo '같은 이름의 실습 자료가 있습니다.' >&2; exit 1
    fi
done
for i in 0 1 2 3 4; do
    if [ -e "$dir/file$i.txt" ] || [ -L "$dir/file$i.txt" ]; then
        echo '실습 파일이 이미 있습니다.' >&2; exit 1
    fi
done
mkdir -p "$dir"
for i in 0 1 2 3 4; do
    printf 'sample file %s\n' "$i" > "$dir/file$i.txt"
done
tar -cf "$archive" -C "$dir" file0.txt file1.txt file2.txt file3.txt file4.txt
(cd "$dir" && ls -C)
mkdir "$unpacked"
mv "$archive" "$unpacked/files.tar"
tar -xvf "$unpacked/files.tar" -C "$unpacked"
