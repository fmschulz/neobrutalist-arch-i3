#!/bin/bash
# Automated Arch Linux update script
# This script updates the system and logs the results

LOG_FILE="/var/log/arch-updates.log"
LOCK_FILE="/var/run/arch-update.lock"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE"
}

# Check if another instance is running
if [ -f "$LOCK_FILE" ]; then
    log_message "ERROR: Update already in progress. Exiting."
    exit 1
fi

# Create lock file
sudo touch "$LOCK_FILE"

# Trap to remove lock file on exit
trap 'sudo rm -f "$LOCK_FILE"' EXIT

log_message "=== Starting Arch Linux system update ==="

# Update package databases
log_message "Updating package databases..."
if sudo pacman -Sy &>> "$LOG_FILE"; then
    log_message "Package databases updated successfully"
else
    log_message "ERROR: Failed to update package databases"
    exit 1
fi

# Check for updates
UPDATES=$(pacman -Qu | wc -l)
if [ "$UPDATES" -eq 0 ]; then
    log_message "No updates available. System is up to date."
    exit 0
fi

log_message "Found $UPDATES package(s) to update"

# Perform system update
log_message "Starting system update..."
if sudo pacman -Su --noconfirm &>> "$LOG_FILE"; then
    log_message "System update completed successfully"
else
    log_message "ERROR: System update failed"
    exit 1
fi

# Clean package cache (keep last 2 versions)
log_message "Cleaning package cache..."
if sudo paccache -rk2 &>> "$LOG_FILE" 2>&1; then
    log_message "Package cache cleaned"
else
    log_message "WARNING: Failed to clean package cache (paccache not installed?)"
fi

# Check if reboot is required
if [ -f /usr/bin/needrestart ]; then
    sudo needrestart -r l &>> "$LOG_FILE"
fi

log_message "=== Arch Linux update completed successfully ==="