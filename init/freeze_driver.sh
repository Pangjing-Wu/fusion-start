#!/bin/bash
set -e

echo "🔍 Detecting installed NVIDIA driver package..."

# Detect the NVIDIA driver package
DRIVER_PKG=$(dpkg -l | grep -E '^ii\s+nvidia-driver-[0-9]+' | awk '{print $2}')

if [ -z "$DRIVER_PKG" ]; then
    echo "❌ NVIDIA driver package not found. Are you sure it's installed?"
    exit 1
fi

echo "✅ Found driver package: $DRIVER_PKG"
echo "📌 Holding it to prevent automatic updates..."

# Lock the driver package
sudo apt-mark hold "$DRIVER_PKG"

# Optionally lock related core libraries (safe, common ones)
RELATED_PKGS=$(dpkg -l | grep -E '^ii\s+libnvidia-(compute|gl|extra|common)-[0-9]+' | awk '{print $2}')
for pkg in $RELATED_PKGS; do
    echo "📌 Also holding $pkg..."
    sudo apt-mark hold "$pkg"
done

echo "✅ Done. These packages are now held:"
apt-mark showhold
