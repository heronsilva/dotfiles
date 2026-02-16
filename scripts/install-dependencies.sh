#!/bin/bash

ensure_dependencies_installed() {
    if command -v sudo >/dev/null 2>&1 && command -v git >/dev/null 2>&1 && command -v python >/dev/null 2>&1; then
        echo "All dependencies are already installed. Skipping..."
        return 0
    fi

    echo "Some dependencies are missing. Installing..."

    case "$(uname -s)" in
        Darwin)
            if command -v brew >/dev/null 2>&1; then
                brew install git || return 1
            else
                echo "Homebrew not found — installing Homebrew (required to install git)..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
                    echo "Failed to install Homebrew. Please install git (via Homebrew or Xcode CLT) and re-run." >&2
                    return 1
                }
                # Load Homebrew into the current shell for this run
                if [ -x /opt/homebrew/bin/brew ]; then
                    eval "$(/opt/homebrew/bin/brew shellenv)"
                elif [ -x /usr/local/bin/brew ]; then
                    eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null || true
                fi
                brew install git || return 1
            fi
            ;;
        Linux)
            if command -v apt >/dev/null 2>&1; then
                sudo apt update && sudo apt install -y git python
            elif command -v dnf >/dev/null 2>&1; then
                sudo dnf install -y git python
            elif command -v pacman >/dev/null 2>&1; then
                sudo pacman -Sy --noconfirm git python
            elif command -v apk >/dev/null 2>&1; then
                sudo apk add --no-cache git python
            else
                echo "No supported package manager found to install git. Please install git and re-run." >&2
                return 1
            fi
            ;;
        *)
            echo "Unsupported OS '$(uname -s)'; please install git and re-run." >&2
            return 1
            ;;
    esac

    echo "Dependencies successfully installed!"
}
