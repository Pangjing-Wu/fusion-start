FROM pytorch/pytorch:2.7.0-cuda12.8-cudnn9-runtime

# ------------------------ 系统依赖 ------------------------
# 安装基础工具和编译依赖

RUN apt-get update && apt-get install -y \
    git \
    sudo \
    openssh-server \
    lsb-release \
    wget \
    curl \
    htop \
    vim \
    build-essential \
    libgl1-mesa-glx \ 
    unzip \ 
    zsh \
    && systemctl enable ssh \
    && service ssh start \
    && rm -rf /var/lib/apt/lists/*

# ------------------------ Python 依赖 ------------------------
# 安装常用数据科学包
RUN pip install --no-cache-dir \
    numpy==1.24.3 \
    pandas==2.0.3 \
    matplotlib==3.7.2 \
    scikit-learn==1.3.0 \
    jupyterlab==4.0.7 \
    ipython

RUN 

# ------------------------ 项目配置 ------------------------
# 设置工作目录
WORKDIR /workspace

# 复制本地代码到容器
COPY . .

# ------------------------ 运行时配置 ------------------------
# 暴露 Jupyter 端口（可选）
EXPOSE 8888

# ------------------------ 验证命令 ------------------------
# 验证 PyTorch 的 GPU 支持
RUN python -c "import torch; print(f'PyTorch版本: {torch.__version__}'); \
    print(f'CUDA可用: {torch.cuda.is_available()}'); \
    print(f'GPU数量: {torch.cuda.device_count()}')"

# ------------------------ 默认启动命令 ------------------------
# 可根据需要修改为直接运行训练脚本
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]