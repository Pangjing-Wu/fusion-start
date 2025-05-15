#!/bin/bash
# Only pull .zshrc and SSH authorized_keys from /mnt/my_settings to home

set -e

MY_SETTING_DIR="/mnt/my_settings"

# Create settings directory if it doesn't exist
if [ ! -d "$MY_SETTING_DIR" ]; then
    echo "Creating $MY_SETTING_DIR..."
    sudo mkdir -p "$MY_SETTING_DIR"
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

# Add code to .zshrc to automatically save settings to /mnt/my_settings on shell exit, without calling an external script
ZSHRC_SAVE_CODE=$(cat <<'EOF'
trap '
    MY_SETTING_DIR="/mnt/my_settings"
    mkdir -p "$MY_SETTING_DIR"
    cp -v "$HOME/.zshrc" "$MY_SETTING_DIR/.zshrc"
    if [ -f "$HOME/.ssh/authorized_keys" ]; then
        mkdir -p "$MY_SETTING_DIR/ssh_pubkeys"
        cp -v "$HOME/.ssh/authorized_keys" "$MY_SETTING_DIR/ssh_pubkeys/authorized_keys"
    fi
' EXIT
EOF
)
if ! grep -Fxq "$ZSHRC_SAVE_CODE" "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo "# Automatically save settings to /mnt/my_settings on shell exit" >> "$HOME/.zshrc"
    echo "$ZSHRC_SAVE_CODE" >> "$HOME/.zshrc"
fi

echo "✅ Pull complete." 