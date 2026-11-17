#!/bin/sh
while :; do
    printf '\n1) 사용자 정보\n2) GPU 또는 CPU 사용률\n'
    printf '3) 메모리 사용량\n4) 디스크 사용량\n5) 종료\n선택: '
    IFS= read -r choice || break
    case "$choice" in
        1) id; who ;;
        2)
            if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi; then
                :
            elif [ "$(uname -s)" = Linux ]; then
                top -b -n 1 | head -n 12
            else top -l 1 -n 0 | head -n 12; fi ;;
        3)
            if command -v free >/dev/null 2>&1; then free -h
            else vm_stat; fi ;;
        4) df -h . ;;
        5) echo '종료합니다.'; break ;;
        *) echo '1~5 중에서 선택하세요.' ;;
    esac
done
