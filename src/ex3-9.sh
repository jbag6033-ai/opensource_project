#!/bin/sh
db=${DB_FILE:-DB.txt}
if [ "$#" -gt 1 ] || { [ "$#" -eq 1 ] && [ -z "$1" ]; }; then
    echo "사용법: sh $0 [검색할이름]" >&2; exit 1
fi
if [ ! -f "$db" ]; then
    echo "DB 파일이 없습니다: $db" >&2; exit 1
fi
# 인자가 없으면 전체 팀원 정보를, 있으면 문자열이 포함된 원본 행을 출력한다.
SEARCH_TEXT=${1-} awk '
    NF>=2 && $NF ~ /^[0-9]/ && index($0, ENVIRON["SEARCH_TEXT"]) { print }
' "$db"
