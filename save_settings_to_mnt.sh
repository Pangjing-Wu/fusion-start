#!/bin/bash
# Save (push) .zshrc and SSH authorized_keys to /mnt/my_settings

set -e

MY_SETTING_DIR="/mnt/my_settings"

# Create settings directory if it doesn't exist
if [ ! -d "$MY_SETTING_DIR" ]; then
    echo "Creating $MY_SETTING_DIR..."
    mkdir -p "$MY_SETTING_DIR"
fi

echo "Saving local settings to $MY_SETTING_DIR..."

# Save .zshrc   
cp -v "$HOME/.zshrc" "$MY_SETTING_DIR/.zshrc"

# Save SSH authorized_keys
if [ -f "$HOME/.ssh/authorized_keys" ]; then
    mkdir -p "$MY_SETTING_DIR/ssh_pubkeys"
    cp -v "$HOME/.ssh/authorized_keys" "$MY_SETTING_DIR/ssh_pubkeys/authorized_keys"
else
    echo "No authorized_keys file found."
fi
echo "✅ Save complete." 