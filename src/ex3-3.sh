#!/bin/sh
printf '과목 점수를 공백으로 구분하여 2개 이상 입력: '
IFS= read -r scores || exit 1
set -f
set -- $scores
if [ "$#" -lt 2 ]; then
    echo '2개 이상의 점수가 필요합니다.' >&2; exit 1
fi
for score do
    if ! printf '%s\n' "$score" | awk '
        /^[0-9]+$/ && $0+0 <= 100 { valid=1 }
        END { exit !valid }
    '; then
        echo '점수는 0~100의 정수여야 합니다.' >&2; exit 1
    fi
done
printf '%s\n' "$@" | awk '
    { score=$1+0; sum+=score
      printf "%d번 과목: %d점, %s등급\n", NR, score, (score>=90?"A":"B") }
    END { avg=sum/NR
          printf "평균: %.2f점, 평균 등급: %s\n", avg, (avg>=90?"A":"B") }
'
