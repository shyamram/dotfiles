#!/usr/local/bin/bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin main

function doIt() {
	echo "In function doIt"
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~
	source ~/.bash_profile
}

mya="${1:-'null'}"
echo "mya: $mya"
if [ "$mya" = "--force" -o "$mya" = "-f" ]; then
	echo "doIt"
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "doIt"
		doIt
	fi
fi
unset doIt
