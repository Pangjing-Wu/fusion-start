# Fusion Start
If your research group is using **Fusion**, then I would like to congratulate you that you will spend your days handling the complicated and unstable HPC (High Performance Computing) environment.

Welcome to **Fusion Start** — a collection of scripts to help you quickly set up and configure your HPC.


## Usage

To get started with **Fusion Start**, you need to run the initialization scripts every time you create a **new environment** or **restart** your HPC/Docker environment. This ensures that all necessary tools, configurations, and user settings are properly applied.

### Step-by-step Usage

1. **Run `step_1.sh`**  
   This script sets up the required user and basic system configuration.  
   **You must run this script first whenever you start a new environment or after a restart.**

2. **Switch to the new user**  
   After `step_1.sh` completes, switch to the newly created user as instructed in the script output.

3. **Run `step_2.sh`**  
   This script installs Miniconda, Oh My Zsh, and other development tools.  
   **Always run this script after switching to the new user.**

>> [!NOTE]
> You need to repeat these steps every time you start a new environment or after a system restart to ensure your setup is complete and up-to-date.


## Overview

This project contains several utility scripts to automate common setup tasks, including:

- Installing basic development tools, including `git`, `conda`, and more
- Installing Oh My Zsh (`init/install_omzsh.sh`)
- Freezing NVIDIA driver and related library versions (`init/freeze_driver.sh`)
- Disabling automatic system updates (`init/freeze_auto_update.sh`)

## Quick Start
### 0. Create a Folder in Data Management and Open a New Online Docker
Before you begin, **create a folder in your Data Management system** (for example, `./dev-1`).

This folder will serve as your persistent mount path. By doing this, you ensure that your code and data are safely stored and will **not be lost when the environment shuts down**.

When creating a new online development environment, please remember to **mount the directory** and turn on **remote access**.

> [!WARNING]  
> If you skip this step, any files saved in the default environment will be deleted when you stop or restart the Docker environment.

> [!NOTE]
> When launching a new Docker environment, make sure to **mount this folder** as a volume. This ensures your scripts, code, and data will always be available, even after environment restarts or shutdowns.


### 1. Upload Environment Content
Upload all of the `.sh` scripts to the default directory of the current shell.

### 2. Make Scripts Executable
Before running, ensure all scripts have execute permissions:

```bash
chmod +x step_1.sh step_2.sh
```

### 3. Change the User after Running `step_1.sh`

After running `step_1.sh`, you will have created a new root user. This is necessary because the default root user cannot start the SSH server.

> [!NOTE]
> Make sure your home directory is located under `/workspace` as specified in the `Dockerfile`. This ensures that all your files are preserved even after restarting the environment.


### 4. Run Initialization Scripts

After creating and switching to your new user, proceed to run `step_2.sh`. This script will:

1. Install Miniconda to manage your Python environments
2. Set up Oh My Zsh for a better shell experience
3. Freeze NVIDIA driver and related library versions to prevent unwanted updates
4. Link your mounted storage for easy access from your home directory
5. Install and configure the SSH server for remote access

Make sure you are logged in as the new user before running `step_2.sh`.

Once these steps are complete, you can connect to your environment using SSH instead of the web interface, providing a much better development experience.


> [!WARNING]  
> According to my experience, if you do not freeze the driver versions, you may lose access to your GPUs and receive errors when running `nvidia-smi`.




## Scripts

| Script                      | Description                                               |
|-----------------------------|-----------------------------------------------------------|
| `step_1.sh`                 | Create user, grant sudo, switch to user                   |
| `step_2.sh`                 | Run init scripts: disable updates, link /mnt, etc.        |
| `init/freeze_auto_update.sh`| Disable all system auto-updates and related services      |
| `init/freeze_driver.sh`     | Hold NVIDIA driver and related libraries                  |
| `init/install_miniconda.sh` | Install Miniconda, set up conda for zsh, start SSH server |
| `init/install_omzsh.sh`     | Install zsh, Oh My Zsh, plugins, configure .zshrc          |
