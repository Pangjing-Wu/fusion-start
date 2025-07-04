#!/bin/bash
echo "===> Disabling automatic update services..."

# Disable apt automatic update timers
sudo systemctl stop apt-daily.timer apt-daily-upgrade.timer
sudo systemctl disable apt-daily.timer apt-daily-upgrade.timer

# Prevent services from restarting automatically
sudo systemctl mask apt-daily.service apt-daily-upgrade.service

# Disable unattended-upgrades service
sudo systemctl stop unattended-upgrades.service
sudo systemctl disable unattended-upgrades.service
sudo systemctl mask unattended-upgrades.service

# Disable motd-news (used for background message push)
sudo systemctl disable motd-news.timer
sudo systemctl mask motd-news.timer

# Disable automatic update configuration files
echo "===> Modifying automatic update configuration..."
sudo sed -i 's/^APT::Periodic::Update-Package-Lists.*$/APT::Periodic::Update-Package-Lists "0";/' /etc/apt/apt.conf.d/10periodic 2>/dev/null
sudo sed -i 's/^APT::Periodic::Unattended-Upgrade.*$/APT::Periodic::Unattended-Upgrade "0";/' /etc/apt/apt.conf.d/10periodic 2>/dev/null

echo "✅ Automatic updates have been completely disabled. It is recommended to reboot and verify the effect."
