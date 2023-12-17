#!/bin/bash

_lgvmFindDockerfile() {
    local file="Dockerfile"
    local paths=("." ".." "docker" "frontend" "front" "backend" "back" "app")
    for path in "${paths[@]}"; do
        if [[ -f "$path/$file" ]]; then
            echo "$path/$file"
            return
        fi
    done
    echo ""
}
_lgvmGetVersionFromDockerfile() {
    local dockerfile="$1"
    local version=$(awk -F'[: -]' '/^FROM golang:/ {print $3; exit}' "$dockerfile" | tr -d '\r')
    echo "$version"
}
lazygvm() {
    local log_option=$1 dockerfile=$(_lgvmFindDockerfile) displayTitle="\033[0;30mLazyGVM •" displayError="\033[0;31m\e[1m❌" displayWaiting="\033[0;33m⏳" displaySuccess="\033[0;32m✅" displayReset="\e[0m"
    if [[ -z $dockerfile ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "$displayTitle $displayError No Dockerfile found$displayReset"
        fi
        return 1
    fi
    local recoveredVersion=$(_lgvmGetVersionFromDockerfile "$dockerfile")
    if [[ -z $recoveredVersion ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "$displayTitle $displayError No Go version found in Dockerfile$displayReset"
        fi
        return 1
    fi
    local version="go$recoveredVersion"
    gvm use "$version" > /dev/null 2>&1 || (echo -e "$displayTitle $displayWaiting Installing Go v$recoveredVersion...$displayReset" && gvm install "$version" > /dev/null && echo -e "$displayTitle \033[0;36m👍 Successfully installed Go v$recoveredVersion$displayReset") || (echo -e "$displayTitle $displayError Failed to use or install Go v$version$displayReset" && return 1)
    gvm use "$version" > /dev/null || (echo -e "$displayTitle $displayError Failed to use Go v$version\nTry to restart your terminal$displayReset" && return 1)
    local displayVersion=$(go version | awk '{print $3}' | sed 's/go//g')
    echo -e "$displayTitle $displaySuccess Now using Go v$recoveredVersion$displayReset"
}