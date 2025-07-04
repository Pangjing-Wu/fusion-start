#!/bin/bash

echo "Setting up init scripts..."

sudo chmod +x init/freeze_auto_update.sh init/freeze_driver.sh init/install_miniconda.sh init/install_omzsh.sh init/link_mount.sh

# Run freeze_driver.sh
echo "Running freeze_driver.sh..."
./init/freeze_driver.sh

# Run freeze_auto_update.sh
echo "Running freeze_auto_update.sh..."
./init/freeze_auto_update.sh

# Run install_miniconda.sh
echo "Running install_miniconda.sh..."
./init/install_miniconda.sh

echo "Installing cuda toolkit..."
# Install CUDA toolkit
./init/install_cuda.sh

# Run install_omzsh.sh
echo "Running install_omzsh.sh..."
./init/install_omzsh.sh

echo "All init scripts executed."