#!/bin/sh
if [ "$#" -ne 2 ]; then
    echo "사용법: sh $0 정수1 정수2" >&2; exit 1
fi
for value in "$1" "$2"; do
    case "${value#-}" in
        ''|*[!0-9]*) echo '정수 두 개를 입력하세요.' >&2; exit 1 ;;
    esac
done
# 선행 0을 제거하여 08과 같은 입력도 10진수로 처리한다.
a=$(printf '%s\n' "$1" | sed 's/^-//; s/^0*//')
b=$(printf '%s\n' "$2" | sed 's/^-//; s/^0*//')
a=${a:-0}; b=${b:-0}
case "$1" in -*) a=$((-a)) ;; esac
case "$2" in -*) b=$((-b)) ;; esac
printf '%s + %s = %s\n' "$a" "$b" "$((a+b))"
printf '%s - %s = %s\n' "$a" "$b" "$((a-b))"
printf '%s * %s = %s\n' "$a" "$b" "$((a*b))"
if [ "$b" -eq 0 ]; then
    echo '나눗셈: 0으로 나눌 수 없습니다.'
else
    printf '%s / %s = %s (정수 나눗셈)\n' "$a" "$b" "$((a/b))"
fi
