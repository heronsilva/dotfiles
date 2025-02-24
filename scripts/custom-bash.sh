#!/bin/bash

prompt_command(){
	# if [ "${PWD##*/}" == "Workbench" ]; then
	# 	dir_icon=""
	# fi

	local fg_def="\e[38;5;255m"
	local bg_def="\e[48;5;0m"
	# local fg_grn="\e[38;2;42;161;152m"
	# local bg_grn="\e[48;2;42;161;152m"
	# local fg_pink="\e[38;2;211;54;130m"
	# local bg_pink="\e[48;2;211;54;130m"
	local fg_grn="\e[38;2;24;94;88m"
	local bg_grn="\e[48;2;24;94;88m"
	local fg_pink="\e[38;2;120;30;75m"
	local bg_pink="\e[48;2;120;30;75m"
	local fg_red="\e[38;2;147;33;31m"
	local bg_red="\e[48;2;147;33;31m"
	local fg_gray="\e[38;5;23m"
	local bg_gray="\e[48;5;23m"
	local end="\e[0m"

	local first="$fg_grn$end"
	local username="\u"
	local hostname="\h"
	local cur_pwd="$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")"
	local workdir="⦃ $cur_pwd ⦄"

	local branch_style="$fg_red$end$bg_red$fg_def  "
	local branch_style_end="$end$fg_red$end"
	local branch_name=$(__git_ps1 "%s")
	local branch_name_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$branch_name")
	local msg="$username in $hostname at $workdir"

	# Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
	local save="\e[s" # Save cursor position
	local rest="\e[u" # Restore cursor to save point

	PS1="\[${save}\e[${COLUMNS:-$(tput cols)}C\e[${#branch_name_stripped}D${branch_name}${rest}\]${msg}\n $ "
}

PROMPT_COMMAND=prompt_command
