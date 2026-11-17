#!/bin/sh
# 각 과목을 4.5 만점으로 환산한 뒤 같은 비중으로 평균한다.
scores=''
while :; do
    printf '\n===================\n'
    printf '1) 과목 성적 추가\n2) 입력된 모든 점수 보기\n'
    printf '3) 평균 점수 확인\n4) 평균 등급 (GPA) 변환\n5) 종료\n'
    printf '===================\n선택: '
    IFS= read -r choice || break
    case "$choice" in
        1)
            printf '점수 (0~100 정수): '
            IFS= read -r score || break
            if printf '%s\n' "$score" | awk '
                /^[0-9]+$/ && $0+0<=100 { valid=1 }
                END { exit !valid }
            '; then
                scores="$scores $score"; echo '추가 완료'
            else echo '0~100의 정수를 입력하세요.'; fi ;;
        2|3|4)
            if [ -z "$scores" ]; then
                echo '먼저 점수를 추가하세요.'; continue
            fi
            printf '%s\n' "$scores" | awk -v mode="$choice" '
                { for(i=1;i<=NF;i++) {
                    s=$i+0; sum+=s; n++
                    if(mode==2) printf "%d번 과목: %d점\n",i,s
                    g=(s>=95?4.5:s>=90?4:s>=85?3.5:s>=80?3:s>=75?2.5:s>=70?2:s>=65?1.5:s>=60?1:0)
                    gp+=g
                } }
                END {
                    if(mode==3) printf "평균 점수: %.2f\n",sum/n
                    if(mode==4) printf "GPA: %.2f / 4.5\n",gp/n
                }' ;;
        5) echo '종료합니다.'; break ;;
        *) echo '1~5 중에서 선택하세요.' ;;
    esac
done
