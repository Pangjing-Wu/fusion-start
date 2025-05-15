# Fusion Start
If your research group is using **Fusion**, then I would like congraduate you that you will waste you nice days on handle the complicated and unstable HPC (High Performance Computing) environment.

Welcome to **Fusion Start** — a collection of scripts to help you quickly set up and configure your HPC.

## Overview

This project contains several utility scripts to automate common setup tasks, including:

- Intaslling all basic develop tools not limited to `git`, `conda`, etc.
- Installing Oh My Zsh (`install_omzsh.sh`)
- Freezing driver versions (`freeze_driver.sh`)
- Linking mount points (`link_mount.sh`)

## Quick Start
### 0. Create a Folder in Data Management and Open a New Online Docker
Before you begin, **create a folder in your Data Management system** (for example, `./dev-1`). 

This folder will serve as your persistent mount path. By doing this, you ensure that your code and data are safely stored and will **not be lost when the environment shuts down**. 

During create new online development environment, please remember to **mount the directory** and turn on **remote access**.

> [!WARNING]  
> If you skip this step, any files saved in the default environment will be deleted when you stop or restart the Docker environment.

> [!NOTE]
> When launching a new Docker environment, make sure to **mount this folder** as a volume. This ensures your scripts, code, and data will always be available, even after environment restarts or shutdowns.


### 1. Upload Environment Content
Upload all of the `.sh` scripts to the default diractory of current shell.

### 2. Make Scripts Executable
Before running, ensure all scripts have execute permissions:

```bash
chmod +x step_1.sh step_2.sh step_3.sh
```

### 3. Change the User after Running `step_1.sh`

After running `step_1.sh`, you will have created a new root user. This is necessary because the default root user cannot start the SSH server.


### 4. Install Remaining 
Then, you should change to the new user before running `step_2.sh`. The `step_2` script will:

1. Install Miniconda for Python environment management
2. Install Oh My Zsh for an improved shell experience
3. Freeze driver versions for system stability
4. Link mount points for easy storage access
5. Install and configure the SSH server

Once these steps are complete, you can connect to your environment using SSH instead of the web interface, providing a much better development experience.


> [!WARNING]  
> According to my experience, if you do not freeze the driver versions, you will find that you lost your GPUs and receive error when running `nvidia-smi`.


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

| Script                     | Description                                         |
|----------------------------|-----------------------------------------------------|
| `step_1.sh`                | Create new user to start SSH service                |
| `step_2.sh`                | Custom initialization step 2                        |
| `install_miniconda.sh`     | Installs Miniconda (Python environment)             |
| `install_omzsh.sh`         | Installs Oh My Zsh for improved shell usage         |
| `freeze_driver.sh`         | Freezes driver versions for reproducibility         |
| `link_mount.sh`            | Links mount points for storage access               |
| `step_3.sh`                | Restores settings from `/mnt/my_settings`           |
| `save_settings_to_mnt.sh`  | Saves settings to `/mnt/my_settings`                |
