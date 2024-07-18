# Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Update... everything!
function update_all() {
    echo "### Update zinit"
    zinit self-update

    echo "\n### Update zinit plugins"
    zinit update

    echo "\n### Update homebrew"
    brew update

    echo "\n### Update homebrew installed software"
    brew upgrade
}
