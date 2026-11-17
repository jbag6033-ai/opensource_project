#!/bin/sh
# sh로 실행되는 프로세스 안에서 환경변수의 전달과 해제를 확인한다.
set -e
line='export MYENV="Hello Shell"'
touch "$HOME/.bashrc"
if ! grep -qxF "$line" "$HOME/.bashrc"; then
    printf '\n%s\n' "$line" >> "$HOME/.bashrc"
fi
export MYENV='Hello Shell'
printf '.bashrc 등록: %s\n' "$line"
printf '현재 스크립트: %s\n' "$MYENV"
sh -c 'printf "자식 sh: %s\n" "${MYENV-미설정}"'
echo '환경변수 해제 후'
unset MYENV
printf '현재 스크립트: %s\n' "${MYENV-미설정}"
sh -c 'printf "자식 sh: %s\n" "${MYENV-미설정}"'
