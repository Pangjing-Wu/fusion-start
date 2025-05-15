#!/bin/bash
# Script to symlink all top-level directories under /mnt to the user's home directory

set -e

echo "🔗 Linking folders from /mnt to $HOME..."

for dir in /mnt/*/; do
    [ -d "$dir" ] || continue  # Skip if not a directory
    name=$(basename "$dir")
    target="$HOME/$name"

    if [ -e "$target" ]; then
        echo "⚠️  Skipping existing item: $target"
    else
        ln -s "$dir" "$target"
        echo "✅ Linked: $target → $dir"
    fi
done

# Add code to .zshrc to automatically create symlinks from /mnt to $HOME on shell startup
echo "🔗 Adding code to .zshrc to automatically create symlinks from /mnt to $HOME on shell startup..."

ZSHRC_LINK_CODE='for dir in /mnt/*/; do [ -d "$dir" ] || continue; name=$(basename "$dir"); target="$HOME/$name"; if [ ! -e "$target" ]; then ln -s "$dir" "$target"; fi; done'
if ! grep -Fxq "$ZSHRC_LINK_CODE" "$HOME/.zshrc"; then
    echo "" >> "$HOME/.zshrc"
    echo "# Automatically update /mnt symlinks to home on shell startup" >> "$HOME/.zshrc"
    echo "$ZSHRC_LINK_CODE" >> "$HOME/.zshrc"
fi

echo "🎉 Done!"