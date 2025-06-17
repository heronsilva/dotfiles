source_if_exists() {
	local file=$1

	if [[ -f "$file" ]]; then
		source "$file" &>/dev/null
	fi
}

# True if $1 is an executable in $PATH
# Works in both {ba,z}sh
# is_bin_in_path
function is_installed {
	if [[ -n $ZSH_VERSION ]]; then
		# echo "is installed"
		builtin whence -p "$1" &>/dev/null
	else # bash:
		# echo "not installed ://"
		builtin type -P "$1" &>/dev/null
	fi
}

function not_alias {
	# local command_type="$(builtin whence -w docker)"
	# if [[ "$command_type" == "alias"]] then
	# 	echo  "is alias"
	# 	# return 1
	# fi

	if [[ $(builtin whence -w $1) == "$1: alias" ]]; then
		return 1
	fi

	return 0
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
	tar) tar cf "$archive" "$@" ;;
	tar.gz | tgz) tar czf "$archive" "$@" ;;
	tar.bz2 | tbz2) tar cjf "$archive" "$@" ;;
	tar.xz | txz) tar cJf "$archive" "$@" ;;
	zip) zip -r "$archive" "$@" ;;
	7z) 7z a "$archive" "$@" ;;
	rar) rar a "$archive" "$@" ;;
	*) echo "Unsupported format: ${archive##*.}" ;;
	esac
}

urlencode() {
	python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read().strip() if sys.stdin.isatty() == False else sys.argv[1]))" "$@"
}

urldecode() {
	python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read().strip() if sys.stdin.isatty() == False else sys.argv[1]))" "$@"
}

addcmd() {
	local command="$1"
	local description="$2"
	local file="$HOME/.zsh/useful_commands.zsh"

	if [[ -z "$command" || -z "$description" ]]; then
		echo "Usage: addcmd <command> <description>"
		return 1
	fi

	if grep -q "$command" "$file"; then
		echo "Command already exists in $file"
		return 0
	fi

	echo "# $description" >>"$file"
	echo "$command" >>"$file"
	echo "\n\n" >>"$file"
	echo "Command added to $file"

	return 0
}
