#!/bin/sh
show_files() {
    echo '함수 안으로 들어 왔음'
    ls "$@"
}
echo '프로그램을 시작합니다.'
show_files "$@"
result=$?
echo '프로그램을 종료합니다.'
exit "$result"
