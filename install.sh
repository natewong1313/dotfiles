#!/bin/bash
function installDeps() {
    sudo pacman -S git rust go fish

    mkdir deps && cd deps
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..

    curl -fsSL https://bun.com/install | bash

    cargo install kanata
}

function setupKanata() {
  # sudo groupdel uinput 2>/dev/null
  # sudo groupadd --system uinput
  #
  # sudo usermod -aG input $USER
  # sudo usermod -aG uinput $USER
  #
  # sudo tee /etc/udev/rules.d/99-input.rules > /dev/null <<EOF
  # KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  # EOF
  #
  # sudo udevadm control --reload-rules && sudo udevadm trigger
}

function installZedMonoFont() {
  mkdir -p ~/.local/share/fonts
  cd /tmp
  curl -fLo "ZedMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ZedMono.zip"
  unzip -o "ZedMono.zip" -d ~/.local/share/fonts/
  rm "ZedMono.zip"
  fc-cache -f -v
}

function setupFish() {
  chsh -s "$(command -v fish)"
}
