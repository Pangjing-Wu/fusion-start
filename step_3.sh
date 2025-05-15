#!/bin/bash
# Only pull .zshrc and SSH authorized_keys from /mnt/my_settings to home

set -e

MY_SETTING_DIR="/mnt/my_settings"

# Create settings directory if it doesn't exist
if [ ! -d "$MY_SETTING_DIR" ]; then
    echo "Creating $MY_SETTING_DIR..."
    mkdir -p "$MY_SETTING_DIR"
fi

echo "Pulling settings from $MY_SETTING_DIR to home..."
# Pull .zshrc
if [ -f "$MY_SETTING_DIR/.zshrc" ]; then
    cp -v "$MY_SETTING_DIR/.zshrc" "$HOME/.zshrc"
else
    echo "No .zshrc found in $MY_SETTING_DIR."
fi

# Pull SSH authorized_keys
if [ -f "$MY_SETTING_DIR/ssh_pubkeys/authorized_keys" ]; then
    mkdir -p "$HOME/.ssh"
    cp -v "$MY_SETTING_DIR/ssh_pubkeys/authorized_keys" "$HOME/.ssh/authorized_keys"
else
    echo "No authorized_keys file found in $MY_SETTING_DIR/ssh_pubkeys."
fi

# Move save_settings_to_mnt.sh to $HOME first
if [ -f "./save_settings_to_mnt.sh" ]; then
    cp -v ./save_settings_to_mnt.sh "$HOME/save_settings_to_mnt.sh"
    chmod +x "$HOME/save_settings_to_mnt.sh"
fi

# Add command to .zshrc to automatically save settings on shell exit
SAVE_CMD="if [ -f \"\$HOME/save_settings_to_mnt.sh\" ]; then \$HOME/save_settings_to_mnt.sh; fi"
if ! grep -Fxq "$SAVE_CMD" "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo "# Automatically save settings to /mnt/my_settings on shell exit" >> "$HOME/.zshrc"
    echo "trap '$SAVE_CMD' EXIT" >> "$HOME/.zshrc"
fi

echo "✅ Pull complete." 