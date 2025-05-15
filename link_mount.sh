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

echo "🎉 Done!"
