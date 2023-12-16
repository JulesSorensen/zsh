#!/bin/bash

_lnvmFindDockerfile() {
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
_lnvmGetVersionFromDockerfile() {
    local dockerfile="$1"
    local version=$(awk -F'[: -]' '/^FROM node:/ {print $3; exit}' "$dockerfile" | tr -d '\r')
    if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$version"
    else
        echo "$version" | cut -d '.' -f 1
    fi
}
lazynvm() {
    local log_option=$1
    local dockerfile=$(_lnvmFindDockerfile)
    if [[ -z $dockerfile ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "\033[0;30mLazyNVM • \033[0;31m\e[1m❌ No Dockerfile found\e[0m"
        fi
        return 1
    fi
    local version=$(_lnvmGetVersionFromDockerfile "$dockerfile")
    if [[ -z $version ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "\033[0;30mLazyNVM • \033[0;31m\e[1m❌ No Node.js version found in Dockerfile\e[0m"
        fi
        return 1
    fi
    nvm use "$version" > /dev/null 2>&1 || (echo -e "\033[0;30m\e[3mLazyNVM • \033[0;33m⏳ Installing Node.js v$version...\e[0m" && nvm install "$version" > /dev/null)
    local current_version=$(node -v)
    echo -e "\033[0;30m\e[3mLazyNVM • \033[0;32m✅ Now using Node.js $current_version\e[0m"
}