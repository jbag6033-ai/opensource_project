#!/bin/sh
printf 'x 값을 공백으로 구분하여 2개 이상 입력: '
IFS= read -r values || exit 1
# 파일 이름 확장을 끄고 입력을 위치 매개변수로 나눈다.
set -f
set -- $values
if [ "$#" -lt 2 ]; then
    echo '2개 이상의 값이 필요합니다.' >&2; exit 1
fi
for x do
    if ! printf '%s\n' "$x" | grep -Eq '^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$'; then
        echo "실수가 아닙니다: $x" >&2; exit 1
    fi
done
for x do
    awk -v x="$x" 'BEGIN {
        printf "x = %s, y = 0.5 * x^2 = %.4f\n", x, 0.5*x*x
    }'
done
