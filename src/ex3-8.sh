#!/bin/sh
set -e
db=${DB_FILE:-DB.txt}
mode=append
if [ "${1-}" = '--reset' ]; then mode=reset; shift; fi
if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
    echo "사용법: sh $0 [--reset] 이름 생일또는전화번호" >&2; exit 1
fi
# 탭과 줄바꿈은 레코드의 구분 문자이므로 입력에서 제외한다.
tab=$(printf '\t')
case "$1$2" in
    *"$tab"*|*'
'*) echo '이름과 정보에는 탭이나 줄바꿈을 넣을 수 없습니다.' >&2; exit 1 ;;
esac
if [ "$mode" = reset ]; then
    printf '%s\t%s\n' "$1" "$2" > "$db"
else
    printf '%s\t%s\n' "$1" "$2" >> "$db"
fi
printf '저장 완료 (%s)\n' "$mode"
cat "$db"
