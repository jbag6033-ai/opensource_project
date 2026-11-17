#!/bin/sh
set -e
db=${DB_FILE:-DB.txt}
mode=append
if [ "${1-}" = '--reset' ]; then mode=reset; shift; fi
if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
    echo "사용법: sh $0 [--reset] 이름 생일또는전화번호" >&2; exit 1
fi
tab=$(printf '\t')
case "$1$2" in
    *"$tab"*|*'
'*) echo '탭이나 줄바꿈은 입력할 수 없습니다.' >&2; exit 1 ;;
esac
case "$2" in *' '*) echo '정보에는 공백을 넣을 수 없습니다.' >&2; exit 1 ;; esac
if [ "$mode" = reset ]; then
    printf '%s %s\n' "$1" "$2" > "$db"
else
    printf '%s %s\n' "$1" "$2" >> "$db"
fi
