#!/bin/bash

# Save SSH authorized_keys if it exists
if [ -f "$HOME/.ssh/authorized_keys" ]; then
    mkdir -p "$MY_SETTING_DIR/ssh_pubkeys"
    cp -v "$HOME/.ssh/authorized_keys" "$MY_SETTING_DIR/ssh_pubkeys/authorized_keys"
fi

echo "✅ SSH authorized_keys saved to $MY_SETTING_DIR/ssh_pubkeys/authorized_keys."