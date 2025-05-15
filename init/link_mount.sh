#!/bin/bash
# Script to symlink /mnt to the user's home directory and set permissions

set -e

# Ensure the current user has read, write, and execute permissions on /mnt
echo "🔒 Setting permissions on /mnt for user $USER..."
sudo chown -R "$USER":"$USER" /mnt
sudo chmod -R 755 /mnt

# Link /mnt to $HOME/mnt if not already linked
target="$HOME/mnt"
if [ -e "$target" ]; then
    echo "⚠️  Skipping: $target already exists."
else
    ln -s /mnt "$target"
    echo "✅ Linked: $target → /mnt"
fi

echo "🎉 Done!"