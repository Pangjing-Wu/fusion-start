#!/bin/bash

echo "Setting up init scripts..."

sudo chmod +x init/install_miniconda.sh init/install_omzsh.sh init/freeze_driver.sh init/link_mount.sh

# Run install_miniconda.sh
echo "Running install_miniconda.sh..."
./init/install_miniconda.sh

# Run install_omzsh.sh
echo "Running install_omzsh.sh..."
./init/install_omzsh.sh

# Run freeze_driver.sh
echo "Running freeze_driver.sh..."
./init/freeze_driver.sh

# Run link_mount.sh
echo "Running link_mount.sh..."
./init/link_mount.sh

echo "All init scripts executed."