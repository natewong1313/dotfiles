sudo groupdel uinput 2>/dev/null
sudo groupadd --system uinput

sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

printf 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"\n' \
| sudo tee /etc/udev/rules.d/99-input.rules > /dev/null

sudo udevadm control --reload-rules && sudo udevadm trigger

newgrp uinput -c kanata

sudo mkdir -p ~/.config/systemd/user

printf '%s\n' \
'[Unit]' \
'Description=Kanata keyboard remapper' \
'Documentation=https://github.com/jtroo/kanata' \
'' \
'[Service]' \
'Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin' \
'#   Uncomment the 4 lines beneath this to increase process priority' \
'#   of Kanata in case you encounter lagginess when resource constrained.' \
'#   WARNING: doing so will require the service to run as an elevated user such as root.' \
'#   Implementing least privilege access is an exercise left to the reader.' \
'#' \
'# CPUSchedulingPolicy=rr' \
'# CPUSchedulingPriority=99' \
'# IOSchedulingClass=realtime' \
'# Nice=-20' \
'Type=simple' \
'ExecStart=/usr/bin/sh -c '\''exec $$(which kanata) --cfg $${HOME}/.config/kanata/config.kbd --no-wait'\''' \
'Restart=on-failure' \
'RestartSec=3' \
'' \
'[Install]' \
'WantedBy=default.target' \
| tee ~/.config/systemd/user/kanata.service > /dev/null
