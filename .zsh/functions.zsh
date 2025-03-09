source_if_exists() {
	local file=$1

	if [[ -f "$file" ]]; then
		source "$file" &>/dev/null
	fi
}

copy() {
	if [[ "${XDG_SESSION_TYPE}" == "wayland" ]]; then
		$1 | wl-copy -n
	fi

	$1 | xclip -selection clipboard
}

mkcd() {
	mkdir "$1"
	cd "$1"
}

function clear_scrollback_buffer {
	# Behavior of clear:
	# 1. clear scrollback if E3 cap is supported (terminal, platform specific)
	# 2. then clear visible screen
	# For some terminal 'e[3J' need to be sent explicitly to clear scrollback
	clear && printf '\e[3J'

	# .reset-prompt: bypass the zsh-syntax-highlighting wrapper
	# https://github.com/sorin-ionescu/prezto/issues/1026
	# https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
	# -R: redisplay the prompt to avoid old prompts being eaten up
	# https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
	zle && zle .reset-prompt && zle -R
}

zle -N clear_scrollback_buffer
bindkey '^L' clear_scrollback_buffer

# nvim() {
# 	# Resolve the absolute path of the first argument (if provided)
# 	local target_dir="$1"
#
# 	if [ -d "$target_dir" ]; then
# 		# If a directory is passed, use it as the working directory
# 		command nvim --cmd "cd $(realpath "$target_dir")" "$@"
# 	else
# 		# If it's a file or no argument, just open normally
# 		command nvim "$@"
# 	fi
# }


compress() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: compress <archive-name> <files...>"
    return 1
  fi

  local archive="$1"
  shift

  case "${archive##*.}" in
    tar)  tar cf "$archive" "$@" ;;
    tar.gz|tgz)  tar czf "$archive" "$@" ;;
    tar.bz2|tbz2) tar cjf "$archive" "$@" ;;
    tar.xz|txz) tar cJf "$archive" "$@" ;;
    zip)  zip -r "$archive" "$@" ;;
    7z)   7z a "$archive" "$@" ;;
    rar)  rar a "$archive" "$@" ;;
    *) echo "Unsupported format: ${archive##*.}" ;;
  esac
}
