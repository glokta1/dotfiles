#!/bin/bash

echo "Cloning kickstart config..."
git clone git@github.com:glokta1/kickstart.nvim.git ~/.dotfiles/nvim
echo "Kickstart config cloned at ~/.dotfiles/nvim"

programs=(ghostty mpv nvim yt-dlp uv zed)
mkdir -p ~/.config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.zshrc ~/.zshrc

for item in "${programs[@]}"; do
	ln -s ~/.dotfiles/"$item" ~/.config/"$item"
done



