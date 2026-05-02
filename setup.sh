#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KICKSTART_REPO="git@github.com:glokta1/kickstart.nvim.git"
NVIM_CONFIG="$HOME/.config/nvim"

if [ ! -d "$NVIM_CONFIG" ]; then
	echo "Cloning kickstart.nvim into $NVIM_CONFIG..."
	git clone "$KICKSTART_REPO" "$NVIM_CONFIG"
else
	echo "Skipping nvim clone — $NVIM_CONFIG already exists"
fi

mkdir -p "$HOME/.config"

link() {
	local src="$1" dest="$2"
	if [ -e "$dest" ] || [ -L "$dest" ]; then
		echo "Skipping $dest — already exists"
	else
		ln -s "$src" "$dest"
		echo "Linked $dest -> $src"
	fi
}

link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/.zshrc" "$HOME/.zshrc"

for item in ghostty mpv yt-dlp uv zed; do
	link "$DOTFILES/$item" "$HOME/.config/$item"
done
