#!/bin/bash

set -euo pipefail

echo "🔧 Applying macOS system defaults..."

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 36

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Screenshots
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"

# Key repeat settings (better for Vim/Nvim)
defaults write -g InitialKeyRepeat -int 16   # Default is 25 (lower is faster)
defaults write -g KeyRepeat -int 2           # Default is 6 (lower is faster)

# disable press and hold for special characters
defaults write -g ApplePressAndHoldEnabled -bool false

# Restart affected apps
killall Dock Finder SystemUIServer >/dev/null 2>&1 || true

echo "✅ macOS defaults applied."
