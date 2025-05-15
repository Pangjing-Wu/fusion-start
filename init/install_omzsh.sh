#!/bin/bash

set -e

# Step 1: Install zsh and dependencies
echo "Installing zsh, git, curl, wget..."
sudo apt update && sudo apt install -y zsh git curl wget vim unzip

# Step 2: Install Oh My Zsh (non-interactive)
echo "Installing Oh My Zsh..."
export RUNZSH=no
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Step 3: Install plugins
echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Step 4: Update ~/.zshrc
echo "Configuring ~/.zshrc..."

sed -i 's/^plugins=(.*)$/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc || \
    echo 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions)' >> ~/.zshrc

cat << 'EOF' >> ~/.zshrc

# Handy aliases
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias grep="grep --color=auto"

# File extension handlers
alias -s html='vim'
alias -s rb='vim'
alias -s py='vim'
alias -s js='vim'
alias -s c='vim'
alias -s java='vim'
alias -s txt='vim'
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
EOF

# Step 5: Change default shell
echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo "✅ Zsh setup complete! Please restart your terminal or log out/in to apply."