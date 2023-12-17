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
    local log_option=$1 dockerfile=$(_lnvmFindDockerfile) displayTitle="\033[0;30mLazyNVM •" displayError="\033[0;31m\e[1m❌" displayWaiting="\033[0;33m⏳" displaySuccess="\033[0;32m✅" displayReset="\e[0m"
    if [[ -z $dockerfile ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "$displayTitle $displayError No Dockerfile found$displayReset"
        fi
        return 1
    fi
    local version=$(_lnvmGetVersionFromDockerfile "$dockerfile")
    if [[ -z $version ]]; then
        if [[ $log_option != "--quiet" ]]; then
            echo -e "$displayTitle $displayError No Node.js version found in Dockerfile$displayReset"
        fi
        return 1
    fi
    nvm use "$version" > /dev/null 2>&1 || (echo -e "$displayTitle $displayWaiting Installing Node.js v$version...$displayReset" && nvm install "$version" > /dev/null && echo -e "$displayTitle \033[0;36m👍 Successfully installed Node.js v$version$displayReset") || (echo -e "$displayTitle $displayError Failed to use or install Node.js v$version$displayReset" && return 1)
    nvm use "$version" > /dev/null || (echo -e "$displayTitle $displayError Failed to use Node.js v$version\nTry to restart your terminal$displayReset" && return 1)
    local displayVersion=$(node -v)
    echo -e "$displayTitle $displaySuccess Now using Node.js $displayVersion$displayReset"
}