#!/bin/sh
db=${DB_FILE:-DB.txt}
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "사용법: sh $0 검색할이름" >&2; exit 1
fi
if [ ! -f "$db" ]; then
    echo "DB 파일이 없습니다: $db" >&2; exit 1
fi
# 정규표현식이 아닌 이름 문자열의 정확한 일치로 검색한다.
SEARCH_NAME=$1 awk -F '\t' '
    $1 == ENVIRON["SEARCH_NAME"] {
        printf "이름: %s, 생일 또는 전화번호: %s\n",$1,$2; found=1
    }
    END { if(!found) print "검색 결과가 없습니다." }
' "$db"
