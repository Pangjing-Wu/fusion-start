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

echo "✅ Pull complete." 

# Copy all sync-scripts to $HOME/.sync-scripts
SYNC_SCRIPTS_SRC="$MY_SETTING_DIR/sync-scripts"
SYNC_SCRIPTS_DEST="$HOME/.sync-scripts"

echo "Copying sync-scripts to $SYNC_SCRIPTS_DEST..."
if [ -d "$SYNC_SCRIPTS_SRC" ]; then
    mkdir -p "$SYNC_SCRIPTS_DEST"
    cp -v "$SYNC_SCRIPTS_SRC"/* "$SYNC_SCRIPTS_DEST"/
else
    echo "No sync-scripts directory found in $MY_SETTING_DIR."
fi

echo "✅ Sync-scripts copied to $SYNC_SCRIPTS_DEST."

# Add code to .zshrc to run all sync scripts on shell sign-out
echo "Adding sync-scripts logout hook to .zshrc..."

if [ -f "$HOME/.zshrc" ]; then
    # Only add the block if not already present
    if ! grep -q "# Fusion sync-scripts on logout" "$HOME/.zshrc"; then
        cat << 'EOF' >> "$HOME/.zshrc"

# Fusion sync-scripts on logout
if [ -d "$HOME/.sync-scripts" ]; then
    for f in "$HOME/.sync-scripts/"*; do
        [ -x "$f" ] && [[ "$f" != *.md ]] && echo "Registering sync script: $f" && trap "$f" EXIT
    done
fi
EOF
    else
        echo "sync-scripts logout hook already present in .zshrc."
    fi
else
    echo "No .zshrc found in home directory to update for sync-scripts."
fi

echo "✅ Sync-scripts logout hook added to .zshrc."

echo "🎉 Done!"