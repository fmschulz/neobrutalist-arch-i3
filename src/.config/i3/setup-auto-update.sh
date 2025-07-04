#!/bin/bash
# Setup script for automated Arch Linux updates

set -e

echo "Setting up automated Arch Linux updates..."

# Copy update script to user config
mkdir -p ~/.config/i3
cp arch-update.sh ~/.config/i3/
chmod +x ~/.config/i3/arch-update.sh

# Install systemd service and timer
sudo cp ../systemd/arch-update.service /etc/systemd/system/
sudo cp ../systemd/arch-update.timer /etc/systemd/system/

# Replace %u with actual username in service file
sudo sed -i "s/%u/$USER/g" /etc/systemd/system/arch-update.service

# Create log file with proper permissions
sudo touch /var/log/arch-updates.log
sudo chmod 644 /var/log/arch-updates.log

# Install optional dependencies
echo "Installing optional dependencies..."
sudo pacman -S --needed --noconfirm pacman-contrib  # for paccache

# Reload systemd and enable timer
sudo systemctl daemon-reload
sudo systemctl enable arch-update.timer
sudo systemctl start arch-update.timer

echo "✓ Automated updates configured successfully!"
echo ""
echo "Timer status:"
sudo systemctl status arch-update.timer --no-pager
echo ""
echo "Next scheduled run:"
sudo systemctl list-timers arch-update.timer --no-pager
echo ""
echo "To check update logs: sudo journalctl -u arch-update.service"
echo "Or view the log file: sudo cat /var/log/arch-updates.log"