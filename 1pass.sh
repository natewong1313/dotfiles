curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
