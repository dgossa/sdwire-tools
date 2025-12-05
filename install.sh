#!/bin/bash
set -e

echo "[+] Installing Dependencies..."
sudo apt update -qq
sudo apt install -y python3-pip python3-libusb1 libusb-1.0-0-dev libftdi1-dev git

echo "[+] Installing SDWire..."
# Install the python tool from the current directory
sudo python3 -m pip install .

echo "[+] Setting up Permissions..."
sudo cp 99-sdwire.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "[+] Adding Shortcuts..."
# Add aliases if they don't exist
if ! grep -q "alias sd-host" ~/.bashrc; then
    echo "alias sd-host='sudo sdwire switch --serial sdwirec_10 host'" >> ~/.bashrc
    echo "alias sd-target='sudo sdwire switch --serial sdwirec_10 target'" >> ~/.bashrc
    echo "alias sd-list='sudo sdwire list'" >> ~/.bashrc
fi

echo "[SUCCESS] Installation Complete!"
echo "You can now use: 'sd-host', 'sd-target', and 'sd-list'"
