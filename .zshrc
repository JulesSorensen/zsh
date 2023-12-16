export RUST=/Users/jules/.cargo/env
export FLYCTL=/Users/jules/.fly/bin
export MONGODB=/usr/local/mongodb/bin
PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$RUST:$MONGODB:$FLYCTL:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[[ -s "/Users/jules/.gvm/scripts/gvm" ]] && source "/Users/jules/.gvm/scripts/gvm"

[ -s "/Users/jules/.bun/_bun" ] && source "/Users/jules/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
alias tmux="TERM=screen-256color-bce tmux"
# https://github.com/ohmyzsh/ohmyzsh/wiki/themes
ZSH_THEME="gozilla"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# scripts
# node version manager
source ~/scripts/lazynvm.sh
lazynvm --quiet
# go version manager
source ~/scripts/lazygvm.sh
lazygvm --quiet

# aliases
# system
alias cls="clear"
alias ll="ls -la"
alias lsl="ls -l"
alias sp="netstat -vanp tcp | grep"
alias kp='function _kp(){ lsof -t -i:"$1" | xargs kill; };_kp'
alias se="set -o allexport; source .env > /dev/null 2>&1; set +o allexport;"
alias ohmyzsh="vi ~/.oh-my-zsh"

# apps
alias c="code ."
alias co="code"

# git
alias gita="git add"
alias gitaa="git add ."
alias gitcm='git commit -m'
alias gitps="git push"
alias gitpl="git pull"
alias gitc='git checkout'
alias gitcc='git checkout -b'
alias gitdb='_gitdb() { read "?Do you really want to delete branch $1? (y/N) " confirm && [[ $confirm == [yY] ]] && git branch -d "$1" && git push origin --delete "$1"; }; _gitdb'
alias gitm='git merge'
alias gits="git stash"
alias gitsp="git stash pop"
alias gitcl="git clone"
alias gitpb='_gitpb() { git checkout "$1" && git pull && git checkout - && git merge "$1"; }; _gitpb'
alias gitl='git log --oneline --decorate --graph'
alias gitf='git fetch'

# version managers
alias nvmu="nvm use"
alias nvmi="nvm install"
alias nvmun="nvm uninstall"
alias gvmu="gvm use"
alias gvmi="gvm install"
alias gvmun="gvm uninstall"

# languages
# rust
alias rr="se; cargo watch -x 'run'"
# golang
alias gr="se; go run ."
# python
alias python="python3"
alias py="python3"
alias pip="pip3"
# node
alias nrd="se; npm run dev;"
alias nrs="se; npm run start;"
alias nrsd="se; npm run start:dev;"
alias nrp="se; npm run prod;"
alias nrb="se; npm run build;"
