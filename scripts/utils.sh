#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}
log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}
log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}
log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

ask_confirm() {
    local prompt="$1"
    if [ "$DOTFILES_AUTO_INSTALL" = "1" ]; then
        return 0
    fi
    if [ ! -t 0 ]; then
        log_warning "Non-interactive shell detected; assuming yes for: $prompt"
        return 0
    fi
    while true; do
        read -p "$prompt [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "Please answer yes or no." ;;
        esac
    done
}

run() {
    if [ "$(id -u)" -ne 0 ] && command_exists sudo; then
        sudo "$@"
    else
        "$@"
    fi
}

detect_os() {
    if [ "$(uname -s)" = "Darwin" ]; then
        echo "macos"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/redhat-release ]; then
        echo "redhat"
    else
        echo "linux"
    fi
}
