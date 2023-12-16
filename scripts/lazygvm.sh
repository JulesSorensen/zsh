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
    local log_option=$1
    local dockerfile=$(_lgvmFindDockerfile)
    if [[ -z $dockerfile ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "\033[0;30mLazyGVM • \033[0;31m\e[1m❌ No Dockerfile found\e[0m"
        fi
        return 1
    fi
    local recoveredVersion=$(_lgvmGetVersionFromDockerfile "$dockerfile")
    if [[ -z $recoveredVersion ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "\033[0;30mLazyGVM • \033[0;31m\e[1m❌ No Go version found in Dockerfile\e[0m"
        fi
        return 1
    fi
    local version="go$recoveredVersion"
    gvm use "$version" > /dev/null 2>&1 || (echo -e "\033[0;30mLazyGVM • \033[0;33m⏳ Installing Go v$recoveredVersion...\e[0m" && gvm install "$version" > /dev/null && gvm use "$version" > /dev/null) || (echo -e "\033[0;30mLazyGVM • \033[0;31m\e[1m❌ Failed to use or install Go v$recoveredVersion\e[0m" && return 1)
    local displayVersion=$(go version | awk '{print $3}' | sed 's/go//g')
    echo -e "\033[0;30m\e[3mLazyGVM • \033[0;32m✅ Now using Go v$recoveredVersion\e[0m"
}