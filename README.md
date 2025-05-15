# Fusion Start
If your research group is using **Fusion**, then I would like to congratulate you that you will spend your days handling the complicated and unstable HPC (High Performance Computing) environment.

Welcome to **Fusion Start** — a collection of scripts to help you quickly set up and configure your HPC.

## Overview

This project contains several utility scripts to automate common setup tasks, including:

- Installing all basic development tools, including but not limited to `git`, `conda`, etc.
- Installing Oh My Zsh (`install_omzsh.sh`)
- Freezing driver versions (`freeze_driver.sh`)
- Linking mount points (`link_mount.sh`)

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
chmod +x step_1.sh step_2.sh step_3.sh
```

### 3. Change the User after Running `step_1.sh`

After running `step_1.sh`, you will have created a new root user. This is necessary because the default root user cannot start the SSH server.


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


### 5. Sync Settings
Syncing Your Shell Settings

To keep your shell configuration and SSH authorized keys consistent across environments, use the following workflow:

- **Pull settings from `/mnt/my_settings`:**
  - This is done automatically when you run `step_3.sh`. It will restore your `.zshrc` and SSH `authorized_keys` from `/mnt/my_settings` to your home directory.

- **Save (push) your current settings to `/mnt/my_settings`:**
  - Run:
    ```sh
    ./save_settings_to_mnt.sh
    ```
    This will copy your current `.zshrc` and SSH `authorized_keys` to `/mnt/my_settings` for persistence.

- **Automatic saving on shell exit (already handled by `step_3.sh`):**
  - When you run `step_3.sh`, it will automatically add a command to your `.zshrc` to save your settings to `/mnt/my_settings` every time you exit your shell:
    ```sh
    # Automatically save settings to /mnt/my_settings on shell exit
    trap 'if [ -f "$HOME/save_settings_to_mnt.sh" ]; then $HOME/save_settings_to_mnt.sh; fi' EXIT
    ```
  - You do not need to manually add this unless you want to customize the behavior.

This setup ensures your shell settings and SSH keys are always up to date and portable between environments.


## Scripts

| Script                      | Description                                               |
|-----------------------------|-----------------------------------------------------------|
| `step_1.sh`                 | Create user, grant sudo, switch to user                   |
| `step_2.sh`                 | Run init scripts: disable updates, link /mnt, etc.        |
| `init/freeze_auto_update.sh`| Disable all system auto-updates and related services      |
| `init/freeze_driver.sh`     | Hold NVIDIA driver and related libraries                  |
| `init/install_miniconda.sh` | Install Miniconda, set up conda for zsh, start SSH server |
| `init/install_omzsh.sh`     | Install zsh, Oh My Zsh, plugins, configure .zshrc          |
| `init/link_mount.sh`        | Set /mnt permissions, symlink to ~/mnt                    |
| `step_3.sh`                 | Copy sync scripts, set logout hook                        |
| `sync-scripts/ssh-pubkey.sh`| Save SSH authorized_keys to /mnt/my_settings/ssh_pubkeys  |
| `sync-scripts/user-setting.sh`| Save .zshrc to /mnt/my_settings                         |
