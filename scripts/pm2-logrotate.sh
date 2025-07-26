#!/bin/bash

echo "[dotfiles:pm2] Setting up pm2-logrotate..."

if ! command -v pm2 &>/dev/null; then
  echo "[dotfiles:pm2] pm2 not found, skipping."
  exit 0
fi

if ! pm2 list | grep -q 'pm2-logrotate'; then
  pm2 install pm2-logrotate
fi

pm2 set pm2-logrotate:max_size 50M
pm2 set pm2-logrotate:retain 7
pm2 set pm2-logrotate:compress true
pm2 set pm2-logrotate:interval '1d'

echo "[dotfiles:pm2] Done."
