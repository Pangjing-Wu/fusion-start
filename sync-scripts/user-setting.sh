#!/bin/bash

# Save .zshrc to /mnt/my_settings
MY_SETTING_DIR="/mnt/my_settings"
mkdir -p "$MY_SETTING_DIR"
cp -v "$HOME/.zshrc" "$MY_SETTING_DIR/.zshrc"

echo "✅ User settings saved to $MY_SETTING_DIR."