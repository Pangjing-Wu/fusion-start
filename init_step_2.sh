#!/bin/bash

chmod +x install_miniconda.sh install_omzsh.sh freeze_driver.sh link_mount.sh

# Run install_miniconda.sh
echo "Running install_miniconda.sh..."
./install_miniconda.sh

# Run install_omzsh.sh
echo "Running install_omzsh.sh..."
./install_omzsh.sh

# Run freeze_driver.sh
echo "Running freeze_driver.sh..."
./freeze_driver.sh

# Run link_mount.sh
echo "Running link_mount.sh..."
./link_mount.sh

echo "All scripts executed."