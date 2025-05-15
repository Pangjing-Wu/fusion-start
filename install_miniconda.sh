mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh


# Switch to the newly created user


# Install and start the SSH server
sudo apt update
sudo apt install -y openssh-server
sudo service ssh start

~/miniconda3/bin/conda init zsh
source ~/.zshrc