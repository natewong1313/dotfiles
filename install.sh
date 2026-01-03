#!/bin/bash

sudo pacman -S git go fish stow brave-browser gh 1password

mkdir deps && cd deps
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

curl -fsSL https://bun.com/install | bash

mkdir -p ~/.local/share/fonts
cd /tmp
curl -fLo "ZedMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ZedMono.zip"
unzip -o "ZedMono.zip" -d ~/.local/share/fonts/
rm "ZedMono.zip"
fc-cache -f -v

chsh -s "$(command -v fish)"
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
nvm install latest

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install kanata
